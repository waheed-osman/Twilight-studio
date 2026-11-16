import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// حالة التطبيق: المفضلة وتقدم مراحل الإنتاج لكل مشهد (محفوظة محلياً).
class AppState extends ChangeNotifier {
  AppState._();

  static final AppState instance = AppState._();

  static const String _stepsKey = 'pipeline_steps';
  static const String _favKey = 'fav_scenes';
  static const int stageCount = 4;

  SharedPreferences? _prefs;
  final Set<String> _steps = <String>{};
  final Set<int> _fav = <int>{};

  Future<void> init() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      _prefs = prefs;
      _steps.addAll(prefs.getStringList(_stepsKey) ?? const <String>[]);
      final List<String> favRaw =
          prefs.getStringList(_favKey) ?? const <String>[];
      for (final String item in favRaw) {
        final int? value = int.tryParse(item);
        if (value != null) {
          _fav.add(value);
        }
      }
    } catch (e) {
      debugPrint('AppState.init failed: $e');
    }
  }

  String _key(int scene, int stage) => '$scene:$stage';

  bool isStepDone(int scene, int stage) => _steps.contains(_key(scene, stage));

  int stepsDone(int scene) {
    int count = 0;
    for (int i = 0; i < stageCount; i++) {
      if (isStepDone(scene, i)) {
        count++;
      }
    }
    return count;
  }

  bool isSceneComplete(int scene) => stepsDone(scene) == stageCount;

  /// نسبة التقدم الكلية بين 0 و 1.
  double progress(int sceneCount) {
    final int total = sceneCount * stageCount;
    if (total == 0) {
      return 0;
    }
    return _steps.length / total;
  }

  Future<void> toggleStep(int scene, int stage) async {
    final String key = _key(scene, stage);
    if (!_steps.remove(key)) {
      _steps.add(key);
    }
    notifyListeners();
    await _save();
  }

  bool isFav(int scene) => _fav.contains(scene);

  Set<int> get favorites => Set<int>.unmodifiable(_fav);

  Future<void> toggleFav(int scene) async {
    if (!_fav.remove(scene)) {
      _fav.add(scene);
    }
    notifyListeners();
    await _save();
  }

  Future<void> resetProgress() async {
    _steps.clear();
    notifyListeners();
    await _save();
  }

  Future<void> _save() async {
    try {
      await _prefs?.setStringList(_stepsKey, _steps.toList());
      await _prefs?.setStringList(
        _favKey,
        _fav.map((int e) => e.toString()).toList(),
      );
    } catch (e) {
      debugPrint('AppState._save failed: $e');
    }
  }
}
