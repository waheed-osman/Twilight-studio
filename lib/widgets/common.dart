import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/models.dart';
import '../services/app_state.dart';
import '../theme.dart';

/// ينسخ النص إلى الحافظة ويعرض إشعاراً.
Future<void> copyToClipboard(
  BuildContext context,
  String text, {
  String label = 'النص',
}) async {
  await Clipboard.setData(ClipboardData(text: text));
  if (!context.mounted) {
    return;
  }
  final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(
    SnackBar(
      content: Text('تم نسخ $label'),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

/// بطاقة قسم بعنوان وأيقونة.
class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: AppColors.amber, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}

/// سطر معلومة: عنوان صغير وقيمة.
class InfoRow extends StatelessWidget {
  const InfoRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
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
          const SizedBox(height: 3),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 14.5,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

/// كتلة نص قابلة للنسخ (للبروميتات).
class CopyBlock extends StatelessWidget {
  const CopyBlock({
    super.key,
    required this.label,
    required this.text,
    this.ltr = true,
  });

  final String label;
  final String text;
  final bool ltr;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.night,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 14, end: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: AppColors.amberSoft,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'نسخ',
                  icon: const Icon(Icons.copy_rounded, size: 19),
                  color: AppColors.textDim,
                  onPressed: () => copyToClipboard(context, text, label: label),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: Directionality(
              textDirection: ltr ? TextDirection.ltr : TextDirection.rtl,
              child: SelectableText(
                text,
                style: const TextStyle(
                  color: AppColors.text,
                  fontSize: 13.5,
                  height: 1.55,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// شريط زمني للمشاهد (العرض نسبي إلى مدة كل مشهد).
class TimelineBar extends StatelessWidget {
  const TimelineBar({super.key, required this.scenes, required this.onTap});

  final List<SceneData> scenes;
  final void Function(SceneData scene) onTap;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState.instance,
      builder: (BuildContext context, Widget? child) {
        return Row(
          children: scenes.map((SceneData s) {
            final bool complete = AppState.instance.isSceneComplete(s.number);
            final Color bg = complete
                ? AppColors.amber
                : (s.number.isOdd ? AppColors.cobalt : AppColors.teal);
            return Expanded(
              flex: s.durationSec,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => onTap(s),
                  child: Container(
                    height: 46,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${s.numberLabel} · ${s.durationSec}ث',
                      style: TextStyle(
                        color: complete
                            ? const Color(0xFF2A1A05)
                            : Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
