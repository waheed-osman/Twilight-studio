import 'package:flutter/material.dart';

import '../models/story_models.dart';
import '../services/story_prompts.dart';
import '../services/story_store.dart';
import '../widgets/common.dart';

/// محرر الشخصية: الرغبة والحاجة والجرح والعيب والقوس والصوت.
class CharacterEditorScreen extends StatefulWidget {
  const CharacterEditorScreen({super.key, required this.character});

  final StoryCharacter character;

  @override
  State<CharacterEditorScreen> createState() => _CharacterEditorScreenState();
}

class _CharacterEditorScreenState extends State<CharacterEditorScreen> {
  final StoryStore _store = StoryStore.instance;
  final Map<String, TextEditingController> _c = <String, TextEditingController>{};

  static const List<List<String>> _fields = <List<String>>[
    <String>['name', 'الاسم', ''],
    <String>['role', 'الدور في القصة', 'بطل، خصم، مرشد، حليف...'],
    <String>['goal', 'الرغبة الظاهرة', 'ماذا يريد أن يحقق؟'],
    <String>['need', 'الحاجة الخفية', 'ما الذي يحتاجه فعلاً دون أن يدري؟'],
    <String>['wound', 'الجرح الماضي', 'حدث قديم شكّل شخصيته'],
    <String>['flaw', 'العيب', 'ما الذي يعيق تحقيقه لهدفه؟'],
    <String>['arc', 'القوس', 'من أين يبدأ وإلى أين ينتهي؟'],
    <String>['voice', 'الصوت اللغوي', 'كيف يتكلم؟ مفرداته، إيقاعه'],
    <String>['notes', 'ملاحظات', 'علاقات، مظهر، تفاصيل مميزة'],
  ];

  @override
  void initState() {
    super.initState();
    final StoryCharacter ch = widget.character;
    final Map<String, String> initial = <String, String>{
      'name': ch.name,
      'role': ch.role,
      'goal': ch.goal,
      'need': ch.need,
      'wound': ch.wound,
      'flaw': ch.flaw,
      'arc': ch.arc,
      'voice': ch.voice,
      'notes': ch.notes,
    };
    for (final List<String> f in _fields) {
      _c[f[0]] = TextEditingController(text: initial[f[0]] ?? '');
    }
  }

  @override
  void dispose() {
    for (final TextEditingController controller in _c.values) {
      controller.dispose();
    }
    _store.saveNow();
    super.dispose();
  }

  void _changed() {
    final StoryCharacter ch = widget.character;
    ch.name = _c['name']!.text;
    ch.role = _c['role']!.text;
    ch.goal = _c['goal']!.text;
    ch.need = _c['need']!.text;
    ch.wound = _c['wound']!.text;
    ch.flaw = _c['flaw']!.text;
    ch.arc = _c['arc']!.text;
    ch.voice = _c['voice']!.text;
    ch.notes = _c['notes']!.text;
    _store.markChanged();
  }

  Future<void> _confirmDelete() async {
    final bool? ok = await showDialog<bool>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: const Text('حذف الشخصية'),
        content: const Text('سيتم حذف هذه الشخصية نهائياً. هل أنت متأكد؟'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
    if (ok == true) {
      _store.removeCharacter(widget.character);
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('محرر الشخصية'),
        actions: <Widget>[
          IconButton(
            tooltip: 'حذف',
            icon: const Icon(Icons.delete_outline),
            onPressed: _confirmDelete,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          for (final List<String> f in _fields)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TextField(
                controller: _c[f[0]],
                onChanged: (String _) => _changed(),
                minLines: 1,
                maxLines: f[0] == 'name' ? 1 : 4,
                decoration: InputDecoration(
                  labelText: f[1],
                  hintText: f[2].isEmpty ? null : f[2],
                ),
              ),
            ),
          const SizedBox(height: 4),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => copyToClipboard(
                context,
                characterPrompt(_store.project, widget.character),
                label: 'بروميت تعميق الشخصية',
              ),
              icon: const Icon(Icons.auto_awesome),
              label: const Text('نسخ بروميت تعميق الشخصية'),
            ),
          ),
        ],
      ),
    );
  }
}
