/// مرحلة من مراحل خط الإنتاج.
class PipelineStage {
  const PipelineStage({
    required this.title,
    required this.goal,
    required this.tools,
    required this.steps,
    required this.outputs,
  });

  final String title;
  final String goal;
  final List<String> tools;
  final List<String> steps;
  final String outputs;
}

/// مراحل إنتاج الفيديو الأربع.
const List<PipelineStage> pipelineStages = <PipelineStage>[
  PipelineStage(
    title: 'السيناريو والحوار',
    goal: 'كتابة النص الدرامي وتحديد الأماكن والشخصيات والانتقالات الزمنية.',
    tools: <String>['Claude', 'ChatGPT'],
    steps: <String>[
      'اعتمد النص الدرامي لكل مشهد كما هو في الدليل.',
      'راجع الحوار الداخلي والخارجي لكل شخصية.',
      'ثبّت التوقيتات (المجموع 34 ثانية).',
    ],
    outputs: 'مشاهد مقسمة بدقة مع الحوار الداخلي والخارجي لكل شخصية.',
  ),
  PipelineStage(
    title: 'التصميم البصري والثابت',
    goal:
        'تثبيت الهوية البصرية للشخصيات (Facial Consistency) وخلفيات المشاهد قبل تحويلها لحركة.',
    tools: <String>['Midjourney', 'DALL-E 3'],
    steps: <String>[
      'انسخ البروميت البصري (Master Prompt) للمشهد من تبويب المشاهد.',
      'ولّد الصور الأساسية للشخصيات والمشاهد.',
      'احتفظ بصور مرجعية ثابتة للشخصيات حتى لا يتغير شكلها بين المشاهد.',
    ],
    outputs: 'صورة ثابتة معتمدة لكل مشهد وصور مرجعية للشخصيتين.',
  ),
  PipelineStage(
    title: 'تحويل الصورة إلى فيديو',
    goal: 'تحويل الصور الثابتة أو النصوص إلى مقاطع فيديو سينمائية متحركة.',
    tools: <String>['Runway Gen-3', 'Luma Dream Machine', 'OpenAI Sora'],
    steps: <String>[
      'أدخل الصورة المعتمدة لكل مشهد.',
      'الصق وصف الحركة (Motion Prompt) المستخرج من خطة الإخراج.',
      'اضبط سرعة الكاميرا ونوع الحركة لتناسب الحالة النفسية للمشهد.',
    ],
    outputs: 'مقطع فيديو لكل مشهد بالمدة المحددة في الدليل.',
  ),
  PipelineStage(
    title: 'الصوت والمؤثرات والدمج',
    goal:
        'دمج التعليق الصوتي وأصوات الشخصيات والمؤثرات والموسيقى ثم المونتاج النهائي.',
    tools: <String>['ElevenLabs', 'Suno AI', 'Udio', 'CapCut', 'Premiere Pro'],
    steps: <String>[
      'ولّد الأداء الصوتي عبر ElevenLabs باستخدام نص الأداء (Cue) لكل مشهد.',
      'ولّد الموسيقى والمؤثرات حسب مود المشهد.',
      'اجمع اللقطات والصوت في برنامج المونتاج وأضف الانتقالات والتدريج اللوني.',
    ],
    outputs: 'الفيلم النهائي بالصوت والموسيقى والتدريج اللوني.',
  ),
];
