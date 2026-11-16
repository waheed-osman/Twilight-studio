import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/story_models.dart';

/// مخزن بيانات استوديو الكتابة (الفكرة، الشخصيات، الفصول) محفوظ محلياً.
class StoryStore extends ChangeNotifier {
  StoryStore._();

  static final StoryStore instance = StoryStore._();

  static const String _key = 'story_v1';

  SharedPreferences? _prefs;
  Timer? _debounce;

  StoryProject project = StoryProject();
  final List<StoryCharacter> characters = <StoryCharacter>[];
  final List<Chapter> chapters = <Chapter>[];

  Future<void> init() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      _prefs = prefs;
      final String? raw = prefs.getString(_key);
      if (raw == null || raw.isEmpty) {
        return;
      }
      final dynamic decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        return;
      }
      final dynamic p = decoded['project'];
      if (p is Map<String, dynamic>) {
        project = StoryProject.fromJson(p);
      }
      final dynamic c = decoded['characters'];
      if (c is List<dynamic>) {
        for (final dynamic item in c) {
          if (item is Map<String, dynamic>) {
            characters.add(StoryCharacter.fromJson(item));
          }
        }
      }
      final dynamic ch = decoded['chapters'];
      if (ch is List<dynamic>) {
        for (final dynamic item in ch) {
          if (item is Map<String, dynamic>) {
            chapters.add(Chapter.fromJson(item));
          }
        }
      }
    } catch (e) {
      debugPrint('StoryStore.init failed: $e');
    }
  }

  int get totalWords =>
      chapters.fold<int>(0, (int sum, Chapter c) => sum + c.wordCount);

  /// يُستدعى بعد أي تعديل: يُحدّث الواجهة ويحفظ بعد مهلة قصيرة.
  void markChanged() {
    notifyListeners();
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), () {
      saveNow();
    });
  }

  Future<void> saveNow() async {
    _debounce?.cancel();
    try {
      final Map<String, dynamic> data = <String, dynamic>{
        'project': project.toJson(),
        'characters': characters.map((StoryCharacter c) => c.toJson()).toList(),
        'chapters': chapters.map((Chapter c) => c.toJson()).toList(),
      };
      await _prefs?.setString(_key, jsonEncode(data));
    } catch (e) {
      debugPrint('StoryStore.saveNow failed: $e');
    }
  }

  StoryCharacter addCharacter() {
    final StoryCharacter c = StoryCharacter();
    characters.add(c);
    markChanged();
    return c;
  }

  void removeCharacter(StoryCharacter c) {
    characters.remove(c);
    markChanged();
  }

  Chapter addChapter() {
    final Chapter c = Chapter(title: 'الفصل ${chapters.length + 1}');
    chapters.add(c);
    markChanged();
    return c;
  }

  void removeChapter(Chapter c) {
    chapters.remove(c);
    markChanged();
  }

  void moveChapter(Chapter c, int delta) {
    final int from = chapters.indexOf(c);
    final int to = from + delta;
    if (from < 0 || to < 0 || to >= chapters.length) {
      return;
    }
    chapters.removeAt(from);
    chapters.insert(to, c);
    markChanged();
  }

  Future<void> clearAll() async {
    project = StoryProject();
    characters.clear();
    chapters.clear();
    notifyListeners();
    await saveNow();
  }
}
