import 'package:flutter/material.dart';

import '../data/project_data.dart';
import '../models/models.dart';
import '../services/app_state.dart';
import '../services/exporter.dart';
import '../theme.dart';
import '../widgets/common.dart';
import 'scene_detail_screen.dart';

/// مشاهد المشروع التجريبي (خريطة الغسق الأخير) مع بحث ومفضلة وشريط زمني.
class ScenesPage extends StatefulWidget {
  const ScenesPage({super.key});

  @override
  State<ScenesPage> createState() => _ScenesPageState();
}

class _ScenesPageState extends State<ScenesPage> {
  String _query = '';
  bool _favOnly = false;

  void _open(SceneData s) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext _) => SceneDetailScreen(scene: s),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState.instance,
      builder: (BuildContext context, Widget? child) {
        final AppState state = AppState.instance;
        final String q = _query.trim().toLowerCase();
        final List<SceneData> shown = projectScenes.where((SceneData s) {
          if (_favOnly && !state.isFav(s.number)) {
            return false;
          }
          return q.isEmpty || s.searchText.toLowerCase().contains(q);
        }).toList();

        return ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            _Header(),
            const SizedBox(height: 16),
            TimelineBar(scenes: projectScenes, onTap: _open),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    onChanged: (String v) => setState(() => _query = v),
                    decoration: const InputDecoration(
                      hintText: 'ابحث في المشاهد والحوار...',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filledTonal(
                  tooltip: 'المفضلة فقط',
                  isSelected: _favOnly,
                  icon: const Icon(Icons.star_border),
                  selectedIcon: const Icon(Icons.star),
                  onPressed: () => setState(() => _favOnly = !_favOnly),
                ),
              ],
            ),
            const SizedBox(height: 14),
            if (shown.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Center(
                  child: Text(
                    'لا توجد نتائج مطابقة',
                    style: TextStyle(color: AppColors.textDim),
                  ),
                ),
              ),
            for (final SceneData s in shown) _SceneTile(scene: s, onTap: _open),
            const SizedBox(height: 8),
            const _BibleSection(),
          ],
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: <Color>[AppColors.cobalt, AppColors.nightSoft],
        ),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'مشروع تجريبي جاهز',
            style: TextStyle(color: AppColors.amberSoft, fontSize: 12.5),
          ),
          const SizedBox(height: 6),
          const Text(
            projectTitle,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: const Text(
              projectTitleEn,
              style: TextStyle(color: AppColors.textDim),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            projectLogline,
            style: TextStyle(height: 1.7, color: AppColors.text),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: <Widget>[
              const Chip(label: Text(projectGenre)),
              Chip(label: Text('${projectScenes.length} مشاهد')),
              Chip(label: Text('$totalDurationSec ثانية')),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: <Widget>[
              TextButton.icon(
                onPressed: () => copyToClipboard(
                  context,
                  buildFullScript(),
                  label: 'السيناريو الكامل',
                ),
                icon: const Icon(Icons.description_outlined, size: 18),
                label: const Text('نسخ السيناريو'),
              ),
              TextButton.icon(
                onPressed: () => copyToClipboard(
                  context,
                  buildAllPrompts(),
                  label: 'كل بروميتات الصور',
                ),
                icon: const Icon(Icons.image_outlined, size: 18),
                label: const Text('نسخ كل البروميتات'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SceneTile extends StatelessWidget {
  const _SceneTile({required this.scene, required this.onTap});

  final SceneData scene;
  final void Function(SceneData scene) onTap;

  @override
  Widget build(BuildContext context) {
    final AppState state = AppState.instance;
    final int done = state.stepsDone(scene.number);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => onTap(scene),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 46,
                  height: 46,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.amber.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    scene.numberLabel,
                    style: const TextStyle(
                      color: AppColors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              scene.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (state.isFav(scene.number))
                            const Icon(Icons.star, size: 18, color: AppColors.amber),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${scene.timecode} · ${scene.durationSec}ث',
                        style: const TextStyle(
                          color: AppColors.textDim,
                          fontSize: 12.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        scene.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(height: 1.5, color: AppColors.text),
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: done / AppState.stageCount,
                        minHeight: 4,
                        borderRadius: BorderRadius.circular(4),
                        backgroundColor: AppColors.border,
                        color: AppColors.amber,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BibleSection extends StatelessWidget {
  const _BibleSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 8, bottom: 12),
          child: Text(
            'دليل الاتساق البصري والسمعي',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SectionCard(
          title: 'الأسلوب العام',
          icon: Icons.palette_outlined,
          children: <Widget>[
            InfoRow(label: 'الكاميرا والعدسات', value: bibleCamera),
            InfoRow(label: 'لوحة الألوان', value: biblePalette),
            InfoRow(label: 'الهوية الصوتية', value: bibleSound),
            CopyBlock(label: 'Master Visual Style', text: masterVisualStyle),
          ],
        ),
        for (final CharacterData c in projectCharacters)
          SectionCard(
            title: '${c.nameAr} (${c.nameEn})',
            icon: Icons.person_outline,
            children: <Widget>[
              InfoRow(label: 'الدور', value: c.role),
              InfoRow(label: 'Voice Profile', value: c.voiceProfile),
              CopyBlock(label: 'Visual Anchor', text: c.visualAnchor),
            ],
          ),
      ],
    );
  }
}
