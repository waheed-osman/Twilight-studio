import 'package:flutter/material.dart';

import '../data/story_guides.dart';
import '../models/story_models.dart';
import '../services/story_prompts.dart';
import '../services/story_store.dart';
import '../theme.dart';
import '../widgets/common.dart';
import 'chapter_editor_screen.dart';
import 'character_editor_screen.dart';

/// القسم الأول: استوديو التأليف الروائي والقصصي.
class WritingPage extends StatelessWidget {
  const WritingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: <Widget>[
          const TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorColor: AppColors.amber,
            labelColor: AppColors.amber,
            unselectedLabelColor: AppColors.textDim,
            tabs: <Widget>[
              Tab(text: 'الفكرة'),
              Tab(text: 'الشخصيات'),
              Tab(text: 'الفصول'),
              Tab(text: 'الهيكل والأدوات'),
            ],
          ),
          const Expanded(
            child: TabBarView(
              children: <Widget>[
                _IdeaTab(),
                _CharactersTab(),
                _ChaptersTab(),
                _ToolsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────── تبويب الفكرة ─────────────────────────────

class _IdeaTab extends StatefulWidget {
  const _IdeaTab();

  @override
  State<_IdeaTab> createState() => _IdeaTabState();
}

class _IdeaTabState extends State<_IdeaTab> with AutomaticKeepAliveClientMixin {
  final StoryStore _store = StoryStore.instance;
  late final TextEditingController _title;
  late final TextEditingController _logline;
  late final TextEditingController _premise;
  late final TextEditingController _theme;
  late final TextEditingController _setting;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    final StoryProject p = _store.project;
    _title = TextEditingController(text: p.title);
    _logline = TextEditingController(text: p.logline);
    _premise = TextEditingController(text: p.premise);
    _theme = TextEditingController(text: p.theme);
    _setting = TextEditingController(text: p.setting);
  }

  @override
  void dispose() {
    _title.dispose();
    _logline.dispose();
    _premise.dispose();
    _theme.dispose();
    _setting.dispose();
    super.dispose();
  }

  Widget _field(
    String label,
    TextEditingController controller,
    void Function(String value) assign, {
    int maxLines = 3,
    String? hint,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        minLines: 1,
        maxLines: maxLines,
        onChanged: (String v) {
          assign(v);
          _store.markChanged();
        },
        decoration: InputDecoration(labelText: label, hintText: hint),
      ),
    );
  }

  Widget _chips(
    String label,
    List<String> options,
    String current,
    void Function(String value) assign,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            color: AppColors.amberSoft,
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: options.map((String o) {
            return ChoiceChip(
              label: Text(o),
              selected: current == o,
              onSelected: (bool selected) {
                setState(() => assign(selected ? o : ''));
                _store.markChanged();
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 14),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final StoryProject p = _store.project;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        SectionCard(
          title: 'الفكرة الأساسية',
          icon: Icons.lightbulb_outline,
          children: <Widget>[
            _field('عنوان القصة', _title, (String v) => p.title = v,
                maxLines: 1),
            _field(
              'الفكرة المركزية (Premise)',
              _premise,
              (String v) => p.premise = v,
              hint: 'ماذا لو...؟ اكتب الفكرة في سطرين',
            ),
            _field(
              'الملخص الدرامي (Logline)',
              _logline,
              (String v) => p.logline = v,
              hint: 'بطل + هدف + عقبة + ما يخسره إن فشل',
            ),
            _field('الثيمة', _theme, (String v) => p.theme = v,
                hint: 'الفكرة الأعمق: الفقد، الحرية، الوفاء...'),
            _field('العالم والمكان', _setting, (String v) => p.setting = v,
                hint: 'الزمان والمكان والأجواء'),
          ],
        ),
        SectionCard(
          title: 'النوع والنبرة والمنظور',
          icon: Icons.tune,
          children: <Widget>[
            _chips('النوع الأدبي', storyGenres, p.genre,
                (String v) => p.genre = v),
            _chips('النبرة', storyTones, p.tone, (String v) => p.tone = v),
            _chips('منظور الراوي', storyPovs, p.pov, (String v) => p.pov = v),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: () => copyToClipboard(
              context,
              ideaPrompt(_store.project),
              label: 'بروميت تطوير الفكرة',
            ),
            icon: const Icon(Icons.auto_awesome),
            label: const Text('نسخ بروميت تطوير الفكرة'),
          ),
        ),
      ],
    );
  }
}

// ──────────────────────────── تبويب الشخصيات ────────────────────────────

class _CharactersTab extends StatelessWidget {
  const _CharactersTab();

  void _open(BuildContext context, StoryCharacter c) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext _) => CharacterEditorScreen(character: c),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: StoryStore.instance,
      builder: (BuildContext context, Widget? child) {
        final List<StoryCharacter> list = StoryStore.instance.characters;
        return ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            FilledButton.icon(
              onPressed: () =>
                  _open(context, StoryStore.instance.addCharacter()),
              icon: const Icon(Icons.person_add_alt_1),
              label: const Text('إضافة شخصية'),
            ),
            const SizedBox(height: 14),
            if (list.isEmpty)
              const _EmptyHint(
                icon: Icons.groups_2_outlined,
                text: 'لا توجد شخصيات بعد. ابدأ بالبطل: ماذا يريد، وما الذي يمنعه؟',
              ),
            for (final StoryCharacter c in list)
              _ItemCard(
                leading: c.name.trim().isEmpty ? '؟' : c.name.trim().substring(0, 1),
                title: c.name.trim().isEmpty ? 'شخصية بلا اسم' : c.name.trim(),
                subtitle: c.role.trim().isEmpty ? c.goal.trim() : c.role.trim(),
                onTap: () => _open(context, c),
              ),
          ],
        );
      },
    );
  }
}

// ───────────────────────────── تبويب الفصول ─────────────────────────────

class _ChaptersTab extends StatelessWidget {
  const _ChaptersTab();

  void _open(BuildContext context, Chapter c) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext _) => ChapterEditorScreen(chapter: c),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: StoryStore.instance,
      builder: (BuildContext context, Widget? child) {
        final StoryStore store = StoryStore.instance;
        final List<Chapter> list = store.chapters;
        return ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '${list.length} فصل · ${store.totalWords} كلمة',
                    style: const TextStyle(color: AppColors.textDim),
                  ),
                ),
                FilledButton.icon(
                  onPressed: () => _open(context, store.addChapter()),
                  icon: const Icon(Icons.add),
                  label: const Text('فصل جديد'),
                ),
              ],
            ),
            const SizedBox(height: 14),
            if (list.isEmpty)
              const _EmptyHint(
                icon: Icons.menu_book_outlined,
                text: 'لا توجد فصول بعد. أنشئ فصلك الأول، أو ابنِ خطة الفصول من تبويب الهيكل.',
              ),
            for (int i = 0; i < list.length; i++)
              _ItemCard(
                leading: '${i + 1}',
                title: list[i].title.trim().isEmpty
                    ? 'فصل بلا عنوان'
                    : list[i].title.trim(),
                subtitle: '${list[i].wordCount} كلمة'
                    '${list[i].summary.trim().isEmpty ? '' : ' · ${list[i].summary.trim()}'}',
                onTap: () => _open(context, list[i]),
                menu: PopupMenuButton<String>(
                  onSelected: (String v) {
                    if (v == 'up') {
                      store.moveChapter(list[i], -1);
                    } else if (v == 'down') {
                      store.moveChapter(list[i], 1);
                    } else if (v == 'delete') {
                      store.removeChapter(list[i]);
                    }
                  },
                  itemBuilder: (BuildContext _) =>
                      const <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(value: 'up', child: Text('تحريك للأعلى')),
                    PopupMenuItem<String>(value: 'down', child: Text('تحريك للأسفل')),
                    PopupMenuItem<String>(value: 'delete', child: Text('حذف')),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}

// ─────────────────────────── تبويب الهيكل والأدوات ───────────────────────────

class _ToolsTab extends StatefulWidget {
  const _ToolsTab();

  @override
  State<_ToolsTab> createState() => _ToolsTabState();
}

class _ToolsTabState extends State<_ToolsTab> {
  final StoryStore _store = StoryStore.instance;

  @override
  Widget build(BuildContext context) {
    final StructureTemplate t = structureById(_store.project.structureId);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        SectionCard(
          title: 'اختر هيكل القصة',
          icon: Icons.account_tree_outlined,
          children: <Widget>[
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: structureTemplates.map((StructureTemplate s) {
                return ChoiceChip(
                  label: Text(s.name),
                  selected: s.id == t.id,
                  onSelected: (bool _) {
                    setState(() => _store.project.structureId = s.id);
                    _store.markChanged();
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            Text(
              t.description,
              style: const TextStyle(color: AppColors.textDim, height: 1.5),
            ),
            const SizedBox(height: 12),
            for (int i = 0; i < t.beats.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColors.cobalt,
                      child: Text(
                        '${i + 1}',
                        style: const TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        t.beats[i],
                        style: const TextStyle(height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 6),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => copyToClipboard(
                  context,
                  outlinePrompt(_store.project, _store.characters),
                  label: 'بروميت خطة الفصول',
                ),
                icon: const Icon(Icons.auto_awesome),
                label: const Text('نسخ بروميت خطة الفصول'),
              ),
            ),
          ],
        ),
        SectionCard(
          title: 'قواعد الكتابة الروائية',
          icon: Icons.tips_and_updates_outlined,
          children: <Widget>[
            for (final String tip in craftTips)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Icon(Icons.circle, size: 7, color: AppColors.amber),
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: Text(tip, style: const TextStyle(height: 1.6))),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}

// ───────────────────────────── عناصر مشتركة ─────────────────────────────

class _EmptyHint extends StatelessWidget {
  const _EmptyHint({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 12),
      child: Column(
        children: <Widget>[
          Icon(icon, size: 48, color: AppColors.textDim),
          const SizedBox(height: 12),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.textDim, height: 1.6),
          ),
        ],
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  const _ItemCard({
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.menu,
  });

  final String leading;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Widget? menu;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: AppColors.amber.withOpacity(0.2),
                  child: Text(
                    leading,
                    style: const TextStyle(
                      color: AppColors.amber,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (subtitle.isNotEmpty) ...<Widget>[
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.textDim,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (menu != null) menu!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
