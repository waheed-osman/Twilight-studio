import '../data/project_data.dart';
import '../models/models.dart';

/// نص كامل للمشهد جاهز للنسخ.
String buildSceneText(SceneData s) {
  final StringBuffer b = StringBuffer();
  b.writeln('المشهد ${s.numberLabel}: ${s.title}');
  b.writeln('${s.slugline} | ${s.timecode} (${s.durationSec}s)');
  b.writeln();
  b.writeln('الوصف الدرامي:');
  b.writeln(s.description);
  b.writeln();
  b.writeln('الكادرات:');
  b.writeln('- نوع اللقطة: ${s.shotType}');
  b.writeln('- حركة الكاميرا: ${s.cameraMove}');
  b.writeln('- الزاوية: ${s.angle}');
  b.writeln('- العدسة: ${s.lens}');
  b.writeln('- ملاحظة المخرج: ${s.directorNote}');
  b.writeln();
  b.writeln('Master Prompt:');
  b.writeln(s.masterPrompt);
  b.writeln();
  b.writeln('Motion Prompt:');
  b.writeln(s.motionPrompt);
  b.writeln();
  b.writeln('Midjourney Params: ${s.mjParams}');
  b.writeln();
  b.writeln('الإضاءة والألوان: ${s.lightingColors}');
  b.writeln('الملابس والإكسسوارات: ${s.wardrobe}');
  b.writeln();
  b.writeln('الحوار (${s.speaker}):');
  b.writeln(s.dialogueText);
  b.writeln('النبرة: ${s.tone}');
  b.writeln('ElevenLabs Cue: ${s.elevenCue}');
  b.writeln();
  b.writeln('المؤثرات الصوتية: ${s.sfx}');
  b.writeln('الموسيقى: ${s.music}');
  b.writeln('المؤثرات البصرية: ${s.vfx}');
  return b.toString();
}

/// كل بروميتات الصور (Master Prompts) مع معاملات Midjourney.
String buildAllPrompts() {
  final StringBuffer b = StringBuffer();
  b.writeln('Master Visual Style:');
  b.writeln(masterVisualStyle);
  b.writeln();
  for (final SceneData s in projectScenes) {
    b.writeln('--- Scene ${s.numberLabel} (${s.timecode}) ---');
    b.writeln('${s.masterPrompt} ${s.mjParams}');
    b.writeln();
  }
  return b.toString();
}

/// السيناريو الكامل للمشروع.
String buildFullScript() {
  final StringBuffer b = StringBuffer();
  b.writeln('$projectTitle ($projectTitleEn)');
  b.writeln('التصنيف: $projectGenre');
  b.writeln(projectLogline);
  b.writeln();
  for (final SceneData s in projectScenes) {
    b.writeln(buildSceneText(s));
    b.writeln('=' * 40);
    b.writeln();
  }
  return b.toString();
}
