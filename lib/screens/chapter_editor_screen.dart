import 'package:flutter/material.dart';

import '../models/story_models.dart';
import '../services/story_prompts.dart';
import '../services/story_store.dart';
import '../theme.dart';
import '../widgets/common.dart';

/// محرر الفصل: عنوان وملخص ونص مع عداد كلمات وأدوات بروميت.
class ChapterEditorScreen extends StatefulWidget {
  const ChapterEditorScreen({super.key, required this.chapter});

  final Chapter chapter;

  @override
  State<ChapterEditorScreen> createState() => _ChapterEditorScreenState();
}

class _ChapterEditorScreenState extends State<ChapterEditorScreen> {
  final StoryStore _store = StoryStore.instance;
  late final TextEditingController _title;
  late final TextEditingController _summary;
  late final TextEditingController _content;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.chapter.title);
    _summary = TextEditingController(text: widget.chapter.summary);
    _content = TextEditingController(text: widget.chapter.content);
  }

  @override
  void dispose() {
    _title.dispose();
    _summary.dispose();
    _content.dispose();
    _store.saveNow();
    super.dispose();
  }

  void _changed() {
    widget.chapter.title = _title.text;
    widget.chapter.summary = _summary.text;
    widget.chapter.content = _content.text;
    _store.markChanged();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Chapter chapter = widget.chapter;
    return Scaffold(
      appBar: AppBar(title: const Text('محرر الفصل')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: _title,
            onChanged: (String _) => _changed(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            decoration: const InputDecoration(labelText: 'عنوان الفصل'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _summary,
            onChanged: (String _) => _changed(),
            minLines: 2,
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: 'ما يجب أن يحدث في الفصل (ملخص)',
              hintText: 'الهدف، الصراع، التحول، الخطاف الختامي',
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _content,
            onChanged: (String _) => _changed(),
            minLines: 14,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            style: const TextStyle(fontSize: 16, height: 1.8),
            decoration: const InputDecoration(
              labelText: 'نص الفصل',
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              '${chapter.wordCount} كلمة',
              style: const TextStyle(color: AppColors.textDim),
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: 'أدوات الذكاء الاصطناعي',
            icon: Icons.auto_awesome,
            children: <Widget>[
              const Text(
                'انسخ البروميت والصقه في Claude أو ChatGPT، ثم ضع النتيجة هنا.',
                style: TextStyle(color: AppColors.textDim, height: 1.5),
              ),
              const SizedBox(height: 12),
              _PromptButton(
                icon: Icons.edit_note,
                label: 'بروميت كتابة الفصل',
                onTap: () => copyToClipboard(
                  context,
                  chapterPrompt(
                    _store.project,
                    _store.characters,
                    _store.chapters,
                    chapter,
                  ),
                  label: 'بروميت كتابة الفصل',
                ),
              ),
              _PromptButton(
                icon: Icons.spellcheck,
                label: 'بروميت تحسين النص',
                onTap: () => copyToClipboard(
                  context,
                  polishPrompt(chapter),
                  label: 'بروميت التحسين',
                ),
              ),
              _PromptButton(
                icon: Icons.movie_filter_outlined,
                label: 'بروميت التحويل إلى مشاهد فيديو',
                onTap: () => copyToClipboard(
                  context,
                  toScreenplayPrompt(_store.project, _store.characters, chapter),
                  label: 'بروميت التحويل إلى سيناريو',
                ),
              ),
              _PromptButton(
                icon: Icons.copy_all,
                label: 'نسخ نص الفصل',
                onTap: () => copyToClipboard(
                  context,
                  chapter.content,
                  label: 'نص الفصل',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PromptButton extends StatelessWidget {
  const _PromptButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: onTap,
          icon: Icon(icon, size: 20),
          label: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(label),
          ),
        ),
      ),
    );
  }
}
