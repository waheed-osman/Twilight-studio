import '../data/story_guides.dart';
import '../models/story_models.dart';

void _field(StringBuffer b, String label, String value) {
  if (value.trim().isNotEmpty) {
    b.writeln('- $label: ${value.trim()}');
  }
}

String _projectBlock(StoryProject p) {
  final StringBuffer b = StringBuffer();
  b.writeln('معلومات القصة:');
  _field(b, 'العنوان', p.title);
  _field(b, 'النوع الأدبي', p.genre);
  _field(b, 'النبرة', p.tone);
  _field(b, 'منظور الراوي', p.pov);
  _field(b, 'الفكرة المركزية', p.premise);
  _field(b, 'الملخص الدرامي', p.logline);
  _field(b, 'الثيمة', p.theme);
  _field(b, 'العالم والمكان', p.setting);
  return b.toString();
}

String _charactersBlock(List<StoryCharacter> list) {
  if (list.isEmpty) {
    return '';
  }
  final StringBuffer b = StringBuffer();
  b.writeln('الشخصيات:');
  for (final StoryCharacter c in list) {
    b.writeln('* ${c.name.trim().isEmpty ? 'شخصية بلا اسم' : c.name.trim()}');
    _field(b, 'الدور', c.role);
    _field(b, 'الرغبة الظاهرة', c.goal);
    _field(b, 'الحاجة الخفية', c.need);
    _field(b, 'العيب', c.flaw);
    _field(b, 'الجرح', c.wound);
    _field(b, 'القوس', c.arc);
    _field(b, 'الصوت اللغوي', c.voice);
    _field(b, 'ملاحظات', c.notes);
  }
  return b.toString();
}

/// بروميت تطوير الفكرة.
String ideaPrompt(StoryProject p) {
  final StringBuffer b = StringBuffer();
  b.writeln(
    'أنت روائي وكاتب قصة محترف. طوّر فكرتي القصصية التالية دون أن تغيّر روحها.',
  );
  b.writeln();
  b.write(_projectBlock(p));
  b.writeln();
  b.writeln('المطلوب:');
  b.writeln('1. صياغة محسّنة للملخص الدرامي (Logline) في جملتين.');
  b.writeln('2. الثيمة والسؤال الدرامي وما يخسره البطل إن فشل.');
  b.writeln('3. ثلاثة تحسينات جريئة على الفكرة مع سبب كل واحد.');
  b.writeln('4. خمسة أسئلة تساعدني على تعميق القصة.');
  return b.toString();
}

/// بروميت بناء الشخصية.
String characterPrompt(StoryProject p, StoryCharacter c) {
  final StringBuffer b = StringBuffer();
  b.writeln('أنت روائي محترف متخصص في بناء الشخصيات. عمّق الشخصية التالية.');
  b.writeln();
  b.write(_projectBlock(p));
  b.writeln();
  b.write(_charactersBlock(<StoryCharacter>[c]));
  b.writeln();
  b.writeln('المطلوب: أكمل الرغبة الظاهرة والحاجة الخفية والجرح والعيب والقوس،');
  b.writeln('واقترح تناقضاً داخلياً مثيراً، وثلاثة أمثلة على كلامها تعكس صوتها،');
  b.writeln('وعلاقاتها المحتملة بباقي الشخصيات.');
  return b.toString();
}

/// بروميت بناء الهيكل وخطة الفصول.
String outlinePrompt(StoryProject p, List<StoryCharacter> characters) {
  final StructureTemplate t = structureById(p.structureId);
  final StringBuffer b = StringBuffer();
  b.writeln('أنت روائي محترف. ابنِ خطة فصول كاملة لقصتي بالهيكل المحدد.');
  b.writeln();
  b.write(_projectBlock(p));
  b.writeln();
  b.write(_charactersBlock(characters));
  b.writeln();
  b.writeln('الهيكل المختار: ${t.name}');
  for (int i = 0; i < t.beats.length; i++) {
    b.writeln('${i + 1}. ${t.beats[i]}');
  }
  b.writeln();
  b.writeln('المطلوب: وزّع النبضات على فصول، ولكل فصل اكتب: الهدف، الصراع،');
  b.writeln('التحول الذي يحدث، الخطاف الختامي، المنظور، وعدد الكلمات التقريبي.');
  return b.toString();
}

/// بروميت كتابة فصل.
String chapterPrompt(
  StoryProject p,
  List<StoryCharacter> characters,
  List<Chapter> all,
  Chapter chapter,
) {
  final StringBuffer b = StringBuffer();
  b.writeln('أنت روائي محترف. اكتب الفصل التالي بالعربية الفصيحة السلسة.');
  b.writeln();
  b.write(_projectBlock(p));
  b.writeln();
  b.write(_charactersBlock(characters));
  b.writeln();
  final int index = all.indexOf(chapter);
  if (index > 0) {
    b.writeln('ملخصات الفصول السابقة:');
    for (int i = 0; i < index; i++) {
      final Chapter prev = all[i];
      final String line =
          prev.summary.trim().isEmpty ? '(بلا ملخص)' : prev.summary.trim();
      b.writeln('- ${prev.title}: $line');
    }
    b.writeln();
  }
  b.writeln('الفصل المطلوب: ${chapter.title}');
  if (chapter.summary.trim().isNotEmpty) {
    b.writeln('ما يجب أن يحدث: ${chapter.summary.trim()}');
  }
  b.writeln();
  b.writeln('التعليمات: ابدأ بخطاف وأنهِ بخطاف، أرِ المشاعر عبر الفعل والتفصيل');
  b.writeln('الحسي، اجعل الحوار طبيعياً ومميزاً لكل شخصية، وتجنب الكليشيهات');
  b.writeln('والوعظ المباشر. الطول التقريبي: 1200 إلى 1800 كلمة.');
  return b.toString();
}

/// بروميت تحسين نص فصل موجود.
String polishPrompt(Chapter chapter) {
  final StringBuffer b = StringBuffer();
  b.writeln('أنت محرر أدبي محترف. حسّن النص التالي مع الحفاظ على صوت الكاتب.');
  b.writeln();
  b.writeln('المطلوب: ملاحظات محددة عن الاتساق والإيقاع والتكرار والثغرات،');
  b.writeln('ثم نسخة محسّنة تُبقي الأحداث كما هي.');
  b.writeln();
  b.writeln('--- ${chapter.title} ---');
  b.writeln(chapter.content.trim());
  return b.toString();
}

/// بروميت تحويل الفصل إلى مشاهد فيديو (يربط الجزء الأول بالثاني).
String toScreenplayPrompt(
  StoryProject p,
  List<StoryCharacter> characters,
  Chapter chapter,
) {
  final StringBuffer b = StringBuffer();
  b.writeln('انتقل إلى الجزء الثاني: السيناريو والحوار والإخراج.');
  b.writeln('حوّل الفصل التالي إلى مشاهد سينمائية مدة كل منها 5 إلى 10 ثوانٍ،');
  b.writeln('بالبنية الخماسية الكاملة لكل مشهد، وأعد استخدام دليل الاتساق.');
  b.writeln();
  b.write(_projectBlock(p));
  b.writeln();
  b.write(_charactersBlock(characters));
  b.writeln();
  b.writeln('--- ${chapter.title} ---');
  b.writeln(chapter.content.trim().isEmpty
      ? chapter.summary.trim()
      : chapter.content.trim());
  return b.toString();
}
