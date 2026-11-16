import 'package:flutter/material.dart';

import '../data/master_prompt.dart';
import '../data/pipeline_data.dart';
import '../data/project_data.dart';
import '../services/app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';

/// خطة الإنتاج: البروميت الرئيسي ومراحل الصورة والصوت والمؤثرات.
class ProductionPage extends StatelessWidget {
  const ProductionPage({super.key});

  Future<void> _confirmReset(BuildContext context) async {
    final bool? ok = await showDialog<bool>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: const Text('تصفير التقدم'),
        content: const Text('سيتم مسح علامات الإنجاز لكل المشاهد. هل تريد المتابعة؟'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('تصفير'),
          ),
        ],
      ),
    );
    if (ok == true) {
      await AppState.instance.resetProgress();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        ListenableBuilder(
          listenable: AppState.instance,
          builder: (BuildContext context, Widget? child) {
            final double p = AppState.instance.progress(projectScenes.length);
            return SectionCard(
              title: 'تقدم المشروع التجريبي',
              icon: Icons.insights,
              children: <Widget>[
                LinearProgressIndicator(
                  value: p,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(8),
                  backgroundColor: AppColors.border,
                  color: AppColors.amber,
                ),
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '${(p * 100).round()}%',
                        style: const TextStyle(color: AppColors.textDim),
                      ),
                    ),
                    TextButton(
                      onPressed: () => _confirmReset(context),
                      child: const Text('تصفير'),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        SectionCard(
          title: 'البروميت الرئيسي (للمؤلف والمخرج)',
          icon: Icons.auto_awesome,
          children: <Widget>[
            const Text(
              'انسخه كاملاً في أول رسالة مع Claude أو ChatGPT، ثم أرسل قصتك. '
              'مقسم إلى ثلاثة أجزاء: التأليف، ثم السيناريو والإخراج، ثم إنتاج الفيديو.',
              style: TextStyle(color: AppColors.textDim, height: 1.6),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => copyToClipboard(
                  context,
                  masterPromptText,
                  label: 'البروميت الرئيسي',
                ),
                icon: const Icon(Icons.copy_rounded),
                label: const Text('نسخ البروميت الرئيسي'),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 4, bottom: 12),
          child: Text(
            'مراحل إنتاج الفيديو',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        for (int i = 0; i < pipelineStages.length; i++)
          _StageCard(index: i, stage: pipelineStages[i]),
      ],
    );
  }
}

class _StageCard extends StatelessWidget {
  const _StageCard({required this.index, required this.stage});

  final int index;
  final PipelineStage stage;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: '${index + 1}. ${stage.title}',
      icon: Icons.layers_outlined,
      children: <Widget>[
        Text(stage.goal, style: const TextStyle(height: 1.6)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: <Widget>[
            for (final String tool in stage.tools)
              Chip(
                label: Text(tool),
                visualDensity: VisualDensity.compact,
              ),
          ],
        ),
        const SizedBox(height: 8),
        for (final String step in stage.steps)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Icon(Icons.check_circle_outline,
                      size: 16, color: AppColors.teal),
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(step, style: const TextStyle(height: 1.5))),
              ],
            ),
          ),
        const SizedBox(height: 4),
        InfoRow(label: 'المخرجات', value: stage.outputs),
      ],
    );
  }
}
