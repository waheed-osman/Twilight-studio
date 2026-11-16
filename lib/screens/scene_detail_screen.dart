import 'package:flutter/material.dart';

import '../models/models.dart';
import '../services/app_state.dart';
import '../services/exporter.dart';
import '../theme.dart';
import '../widgets/common.dart';

/// تفاصيل المشهد بأقسامه الخمسة وتتبع مراحل الإنتاج.
class SceneDetailScreen extends StatelessWidget {
  const SceneDetailScreen({super.key, required this.scene});

  final SceneData scene;

  static const List<String> _stageNames = <String>[
    'السيناريو',
    'الصورة',
    'الفيديو',
    'الصوت والدمج',
  ];

  @override
  Widget build(BuildContext context) {
    final AppState state = AppState.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text('المشهد ${scene.numberLabel}'),
        actions: <Widget>[
          ListenableBuilder(
            listenable: state,
            builder: (BuildContext context, Widget? child) {
              final bool fav = state.isFav(scene.number);
              return IconButton(
                tooltip: 'المفضلة',
                icon: Icon(fav ? Icons.star : Icons.star_border),
                color: fav ? AppColors.amber : null,
                onPressed: () => state.toggleFav(scene.number),
              );
            },
          ),
          IconButton(
            tooltip: 'نسخ المشهد كاملاً',
            icon: const Icon(Icons.copy_all),
            onPressed: () => copyToClipboard(
              context,
              buildSceneText(scene),
              label: 'المشهد ${scene.numberLabel}',
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Text(
            scene.title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              scene.slugline,
              style: const TextStyle(
                color: AppColors.amberSoft,
                fontSize: 12.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${scene.timecode} · ${scene.durationSec} ثوانٍ',
            style: const TextStyle(color: AppColors.textDim),
          ),
          const SizedBox(height: 16),
          _ProgressCard(scene: scene, stageNames: _stageNames),
          SectionCard(
            title: '1. الوصف الدرامي',
            icon: Icons.theaters_outlined,
            children: <Widget>[
              Text(scene.description, style: const TextStyle(height: 1.8)),
            ],
          ),
          SectionCard(
            title: '2. الكادرات السينمائية',
            icon: Icons.videocam_outlined,
            children: <Widget>[
              InfoRow(label: 'نوع اللقطة', value: scene.shotType),
              InfoRow(label: 'حركة الكاميرا', value: scene.cameraMove),
              InfoRow(label: 'الزاوية', value: scene.angle),
              InfoRow(label: 'العدسة والتأطير', value: scene.lens),
              InfoRow(label: 'ملاحظة المخرج', value: scene.directorNote),
            ],
          ),
          SectionCard(
            title: '3. البروميت البصري',
            icon: Icons.image_outlined,
            children: <Widget>[
              CopyBlock(label: 'Master Prompt', text: scene.masterPrompt),
              CopyBlock(label: 'Motion Prompt', text: scene.motionPrompt),
              CopyBlock(label: 'Midjourney Params', text: scene.mjParams),
              InfoRow(label: 'الإضاءة والألوان', value: scene.lightingColors),
              InfoRow(label: 'الملابس والإكسسوارات', value: scene.wardrobe),
            ],
          ),
          SectionCard(
            title: '4. الحوار والتعليق الصوتي',
            icon: Icons.record_voice_over_outlined,
            children: <Widget>[
              InfoRow(label: 'المتحدث / الأسلوب', value: scene.speaker),
              InfoRow(label: 'النص', value: scene.dialogueText),
              InfoRow(label: 'النبرة والمشاعر', value: scene.tone),
              CopyBlock(label: 'ElevenLabs Cue', text: scene.elevenCue),
            ],
          ),
          SectionCard(
            title: '5. المؤثرات السمعية والبصرية',
            icon: Icons.graphic_eq,
            children: <Widget>[
              InfoRow(label: 'المؤثرات المحيطة (SFX)', value: scene.sfx),
              InfoRow(label: 'الموسيقى التصويرية', value: scene.music),
              InfoRow(label: 'المؤثرات البصرية (VFX)', value: scene.vfx),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({required this.scene, required this.stageNames});

  final SceneData scene;
  final List<String> stageNames;

  @override
  Widget build(BuildContext context) {
    final AppState state = AppState.instance;
    return ListenableBuilder(
      listenable: state,
      builder: (BuildContext context, Widget? child) {
        return SectionCard(
          title: 'تقدم الإنتاج (${state.stepsDone(scene.number)}/${AppState.stageCount})',
          icon: Icons.checklist_rtl,
          children: <Widget>[
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: <Widget>[
                for (int i = 0; i < stageNames.length; i++)
                  FilterChip(
                    label: Text(stageNames[i]),
                    selected: state.isStepDone(scene.number, i),
                    onSelected: (bool _) => state.toggleStep(scene.number, i),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
