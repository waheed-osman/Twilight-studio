import '../models/models.dart';

// ─────────────────────────── بيانات المشروع ───────────────────────────

const String projectTitle = 'خريطة الغسق الأخير';
const String projectTitleEn = 'The Last Twilight Chart';
const String projectGenre = 'دراما شاعرية وغموض';
const String projectLogline =
    'في سباق صامت مع الصقيع الزاحف، يعبر رحالة مسنّ أطلال مرصد صحراوي وأزقة '
    'مدينة عتيقة مبللة بالمطر لاستعادة خريطة نجمية مفقودة وتسلم رسالة الوداع '
    'الأخيرة من تلميذه.';

// ─────────────────────── دليل الاتساق البصري والسمعي ───────────────────────

const String bibleCamera =
    'ARRI Alexa 35 · Atlas Orion Anamorphic (35mm, 50mm, 75mm) · Kodak 500T Emulation';

const String biblePalette =
    'لوحة لونية ثنائية التباين (Teal & Amber) ترتكز على الأزرق النيلي البارد '
    'للغسق والمطر مقابل الذهبي النحاسي الدافئ لضوء الفانوس، مع تشبع لوني '
    'منخفض يمنح العمل وقاراً شاعرياً.';

const String bibleSound =
    'تصميم صوتي حميمي يوازن بين الصمت الصحراوي المهيب ووقع المطر المتقطع '
    'على الحجر، تتخلله مقطوعة وترية منخفضة الإيقاع بآلة التشيلو والعود '
    'الصامت لإبراز التوتر الشاعري.';

const String masterVisualStyle =
    'Shot on 35mm Kodak Vision3 500T film, ARRI Alexa 35 with Atlas Orion '
    'Anamorphic lenses, rich chiaroscuro high-contrast lighting, deep teal and '
    'cobalt shadows balanced against warm amber highlights, organic subtle film '
    'grain, atmospheric haze, photorealistic textures.';

// ─────────────────────────────── الشخصيات ───────────────────────────────

const List<CharacterData> projectCharacters = <CharacterData>[
  CharacterData(
    nameAr: 'الشيخ حكيم',
    nameEn: 'Hakim the Elder Traveler',
    role: 'الرحالة المسنّ — البطل الرئيسي',
    voiceProfile:
        'صوت رجولي رخيم دافئ مثقل ببحّة الحكمة وتعب السفر، إيقاع بطيء متزن '
        'مع أنفاس مسموعة ووقفة تأملية بين الجمل.',
    visualAnchor:
        '70-year-old Middle Eastern man with weathered olive skin, deep-set '
        'amber eyes, neatly trimmed silver-white beard, wearing a heavy '
        'charcoal-gray hooded wool cloak over a dark indigo linen tunic, worn '
        'brown leather satchel strapped across his chest, carrying an ornate '
        'tarnished brass oil lantern emitting warm amber light',
  ),
  CharacterData(
    nameAr: 'سالم',
    nameEn: 'Salim the Apprentice',
    role: 'التلميذ — الشخصية المحورية الثانية',
    voiceProfile:
        'صوت شاب خفيض ونقي يحمل نبرة قلق مكتوم وولاء عميق، متسارع قليلاً في '
        'البداية ثم يهدأ عند التسليم.',
    visualAnchor:
        '24-year-old Middle Eastern young man with sharp dark eyes, short '
        'tousled black hair, light stubble, wearing a rain-dampened dark '
        'olive-green canvas coat over a textured brown wool sweater, holding a '
        'wax-sealed aged parchment envelope',
  ),
];

// ──────────────────────────────── المشاهد ────────────────────────────────

const List<SceneData> projectScenes = <SceneData>[
  // ───────────── المشهد 01 ─────────────
  SceneData(
    number: 1,
    title: 'صعود الغسق نحو الأطلال',
    slugline: 'EXT. DESERT DUNES & ANCIENT OBSERVATORY RUINS - BLUE HOUR',
    timecode: '00:00 — 00:08',
    startSec: 0,
    durationSec: 8,
    description:
        'في ساعة الغسق الزرقاء الصامتة، يشق الرحالة المسنّ طريقه صعوداً عبر '
        'كثيب رملي بارد نحو قمة تعلوها أطلال مرصد فلكي متداعٍ. تتصاعد أنفاسه '
        'البيضاء في الهواء المتجمد بينما يتأرجح الفانوس النحاسي في يده، مرسلاً '
        'بقعة ضوء ذهبية وحيدة تتحدى زرقة الليل الزاحف وبلورات الصقيع التي '
        'بدأت تكسو الرمال.',
    shotType:
        'لقطة عامة واسعة (Extreme Wide Shot) تتحول تدريجياً إلى لقطة متوسطة بعيدة',
    cameraMove:
        'تتبع جانبي بطيء مع تقدم للأمام (Slow Side-Tracking Push-in) على سكة منزلقة',
    angle:
        'زاوية منخفضة قليلاً (Low Angle) لتعظيم شموخ الأطلال مقابل ضآلة الجسد البشري',
    lens:
        '35mm Anamorphic · f/2.0 · قاعدة الأثلاث مع وضع الرحالة في الثلث السفلي الأيمن',
    directorNote:
        'الزاوية المنخفضة والعدسة الواسعة تكرّسان العزلة الشاعرية للرحالة '
        'وتبرزان الصراع البصري بين اتساع الصحراء المتجمدة وضوء الفانوس الصغير.',
    masterPrompt:
        'Cinematic wide shot in blue hour twilight across silent desert sand '
        'dunes leading up to crumbling stone ruins of an ancient observatory on '
        'a ridge, a 70-year-old Middle Eastern man with weathered olive skin, '
        'deep-set amber eyes, neatly trimmed silver-white beard, wearing a heavy '
        'charcoal-gray hooded wool cloak over a dark indigo linen tunic, worn '
        'brown leather satchel strapped across his chest, carrying an ornate '
        'tarnished brass oil lantern emitting warm amber light, frost glistening '
        'on sand ridges, faint icy mist drifting low, deep cobalt blue shadows '
        'contrasting warm orange lantern glow on his cloak, shot on 35mm Kodak '
        'Vision3 500T film, ARRI Alexa 35 with Atlas Orion Anamorphic 35mm lens, '
        'chiaroscuro lighting, rich organic film grain, atmospheric depth',
    motionPrompt:
        'Slow deliberate footsteps crunching up the sandy slope, heavy wool '
        'cloak swaying gently in cold desert breeze, brass lantern swinging '
        'subtly casting shifting warm shadows across frost-dusted sand, slow '
        'smooth camera push-in from lower right.',
    mjParams: '--ar 21:9 --style raw --v 6.1',
    lightingColors:
        'إضاءة غسق زرقاء باردة تسيطر على السماء والكثبان، مخترقة بضوء فانوس '
        'كهرماني دافئ يركز الانتباه على وجه الرحالة وطيات ردائه.',
    wardrobe:
        'عباءة صوفية ثقيلة رمادية داكنة بغطاء رأس، حقيبة جلدية متقاطعة، '
        'وفانوس نحاسي منقوش متأكسد يلمع بزيته الدافئ.',
    speaker: 'الرحالة المسنّ (تعليق صوتي داخلي - Voiceover)',
    dialogueText:
        'قبل أن يبتلع الصقيع ذاكرة السماء، لا بد أن أبلغ الحجر الذي حفظ أسرار النجوم.',
    tone:
        'نبرة هادئة مثقلة بالوقار والحنين، إلقاء متأنٍ يتخلله زفير خفيف يشي '
        'ببرودة الجو.',
    elevenCue:
        '[whispering, gravelly elderly male voice, slow melancholic pace, deep '
        'warm resonance, subtle breathiness, cinematic narration]',
    sfx:
        'صفير رياح صحراوية باردة منخفض التردد، صوت احتكاك الأقدام بالرمال '
        'المتجمدة، وصرير خفيف لحلقات الفانوس النحاسي.',
    music:
        'موسيقى أمبيانت شاعرية حزينة ترتكز على نغمة تشيلو طويلة متصاعدة ببطء '
        'مع رنين معدني خافت.',
    vfx:
        'بخار أنفاس متجمد رقيق، ذرات جليد عالقة في الهواء تعكس ضوء الفانوس، '
        'وتدريج لوني يعمّق زرقة الظلال مع هالة توهج ناعمة حول اللهب.',
  ),

  // ───────────── المشهد 02 ─────────────
  SceneData(
    number: 2,
    title: 'الخريطة تحت الصقيع',
    slugline: 'INT. ANCIENT OBSERVATORY RUINS - NIGHT',
    timecode: '00:08 — 00:16',
    startSec: 8,
    durationSec: 8,
    description:
        'داخل قاعة المرصد المكشوفة جزئياً للسماء، يتقدم الرحالة نحو مذبح حجري '
        'دائري تتوسطه خريطة نجمية أثرية على رقٍ جلدي قديم بدأت حوافه تتجمد '
        'بالصقيع. يقترب بالفانوس فتشتعل التفاصيل الفلكية الذهبية تحت الضوء، '
        'وتنفرج أسارير وجهه للحظة وهو يمرر أصابعه المرتجفة فوق مسار نجمي '
        'مفقود قبل أن يطوي الخريطة بحذر.',
    shotType:
        'لقطة متوسطة قريبة (Medium Close-Up) تنتقل إلى لقطة قريبة جداً (Insert '
        'Close-Up) لليد والخريطة',
    cameraMove:
        'دوران بطيء نصف دائري حول الطاولة الحجرية (Slow Orbit) يتبعه إمالة للأسفل',
    angle:
        'زاوية مرتفعة قليلاً (High Angle Over-the-Shoulder) تكشف تفاصيل الخريطة',
    lens:
        '50mm Anamorphic · f/1.8 · عمق ميدان ضحل يعزل تفاصيل الخريطة عن الخلفية الحجرية',
    directorNote:
        'الحركة الدائرية البطيئة تحاكي دوران الأفلاك حول الإسطرلاب وتمنح لحظة '
        'الاكتشاف ثقلاً درامياً وروحانياً.',
    masterPrompt:
        'Cinematic medium close-up inside crumbling open-roof ancient stone '
        'observatory at night, moonlight filtering through broken stone arches, '
        'a 70-year-old Middle Eastern man with weathered olive skin, deep-set '
        'amber eyes, neatly trimmed silver-white beard, wearing a heavy '
        'charcoal-gray hooded wool cloak over a dark indigo linen tunic, worn '
        'brown leather satchel strapped across his chest, holding an ornate '
        'tarnished brass oil lantern emitting warm amber light directly over a '
        'frost-rimmed stone astrolabe table, unveiling an aged parchment '
        'celestial star map with intricate gold-ink constellations and Arabic '
        'astronomical markings, frost crystals creeping across the table edges, '
        'chiaroscuro lighting mixing cool silver moonlight and warm golden '
        'lantern glow on his weathered hands and beard, 35mm Kodak Vision3 500T, '
        'ARRI Alexa 35 Atlas Orion Anamorphic 50mm, rich texture, shallow depth '
        'of field',
    motionPrompt:
        'Camera smoothly orbits around the stone table, the elderly man leans '
        'in lowering the brass lantern closer to the parchment, frost glints '
        'subtly as warm golden light sweeps across engraved gold constellations, '
        'his weathered fingers gently trace a star line.',
    mjParams: '--ar 21:9 --style raw --v 6.1',
    lightingColors:
        'تباين حاد بين ضوء القمر الفضي البارد الساقط من السقف المهدم ووهج '
        'الفانوس البرتقالي المركز فوق الرق الأثري.',
    wardrobe:
        'العباءة الصوفية ذاتها مغطاة بغبار خفيف وندى متجمد، الفانوس النحاسي، '
        'وطاولة الإسطرلاب الحجرية مع الخريطة النجمية المذهبة.',
    speaker: 'صمت درامي — همس أنفاس ووقع صقيع',
    dialogueText:
        'صمت تأملي يقطعه تنهد ارتياح قصير من الشيخ حكيم وهو يتأمل الخريطة.',
    tone: 'زفير دافئ متقطع يعبر عن الرهبة والاطمئنان المؤقت.',
    elevenCue:
        '[soft relieved exhale, quiet elderly breath in cold air, faint '
        'contemplative hum, no spoken words]',
    sfx:
        'حفيف الورق الجلدي المتصلب بالبرد، صوت أزيز خفيف لتمدد الجليد على '
        'الحجر، ونبض رياح بعيدة عبر الأقواس المهدمة.',
    music:
        'دخول آلة عود منفردة بنغمات متباعدة دافئة تمتزج مع طبقة وترية غامضة '
        'لتأكيد لحظة الكشف.',
    vfx:
        'تكثف بلورات الصقيع على أطراف الحجر، انعكاس دقيق لحبر الخريطة الذهبي '
        'تحت حركة اللهب، وتنعيم حواف التوهج الأنامورفيكي.',
  ),

  // ───────────── المشهد 03 ─────────────
  SceneData(
    number: 3,
    title: 'أزقة الحجر والمطر',
    slugline: 'EXT. ANCIENT CITY STONE ALLEYWAY - RAINY NIGHT',
    timecode: '00:16 — 00:24',
    startSec: 16,
    durationSec: 8,
    description:
        'انتقال مكاني وزماني سلس إلى قلب مدينة عتيقة في منتصف الليل تحت أمطار '
        'غزيرة هادئة. يسير الرحالة المسنّ بثبات داخل زقاق حجري ضيق تتلألأ '
        'أرضيته المرصوفة بالحصى المبتل كالمرآة السوداء، حاملاً فانوسه الذي '
        'يرسم انعكاسات ذهبية متموجة في برك الماء بينما يحكم إغلاق حقيبته '
        'الجلدية التي تضم الخريطة.',
    shotType: 'لقطة كاملة متوسطة (Medium Full Shot) تتحرك عبر عمق الزقاق',
    cameraMove:
        'تراجع تتبعي سلس للخلف أمام الشخصية (Smooth Steadicam Pull-Out) يكشف '
        'طول الزقاق الضيق',
    angle:
        'زاوية بمستوى العين (Eye-Level) منخفضة قليلاً لالتقاط انعكاسات المطر على الأرض',
    lens:
        '35mm Anamorphic · f/2.0 · خطوط تلاشي هندسية قوية لجدران الحجر نحو نقطة المنتصف',
    directorNote:
        'التراجع البطيء أمام الرحالة يجعله يقود المشاهد داخل متاهة المدينة '
        'العتيقة ويعزز الإحساس بالترقب قبيل اللقاء الحاسم.',
    masterPrompt:
        'Cinematic atmospheric shot in a narrow wet cobblestone alleyway of an '
        'ancient Middle Eastern stone city at rainy night, gentle steady '
        'rainfall creating glistening puddles and water reflections, a '
        '70-year-old Middle Eastern man with weathered olive skin, deep-set '
        'amber eyes, neatly trimmed silver-white beard, wearing a heavy '
        'charcoal-gray hooded wool cloak soaked on the shoulders over a dark '
        'indigo linen tunic, worn brown leather satchel strapped across his '
        'chest holding the rolled map, carrying an ornate tarnished brass oil '
        'lantern emitting warm amber light, golden light shimmering across wet '
        'limestone walls and dark puddles, misty rain-drenched air, deep teal '
        'shadows and warm amber highlights, shot on 35mm Kodak Vision3 500T, '
        'ARRI Alexa 35 Atlas Orion Anamorphic 35mm, realistic chiaroscuro '
        'lighting, authentic wet stone textures',
    motionPrompt:
        'Steady natural rain falling through lantern light beams, water ripples '
        'in cobblestone puddles, the elderly traveler walks forward steadily '
        'with heavy wet wool cloak swaying, camera glides smoothly backward '
        'maintaining consistent distance.',
    mjParams: '--ar 21:9 --style raw --v 6.1',
    lightingColors:
        'أزرق ليلي داكن في عمق الزقاق مع لمسات كهرمانية حادة تنعكس من الفانوس '
        'على الحجارة الرطبة والبرك.',
    wardrobe:
        'العباءة الصوفية المبللة بالمطر عند الكتفين وغطاء الرأس المنسدل، '
        'الحقيبة الجلدية محكمة الإغلاق، والفانوس النحاسي المضيء.',
    speaker: 'الرحالة المسنّ (تعليق صوتي - Voiceover)',
    dialogueText:
        'تتغير المدن وتغسل الأمطار آثار العابرين، لكن الرسالة التي تنتظر في '
        'الظل لا يمحوها الماء.',
    tone:
        'صوت أعمق وأكثر حزماً رغم التعب، بإيقاع يتناغم مع وقع الخطوات على '
        'الحجر المبلل.',
    elevenCue:
        '[deep reflective elderly male voice, steady resolute pacing, slight '
        'weariness, poetic cadence, subtle room tone]',
    sfx:
        'إيقاع متواصل للمطر المتساقط على الحجر، صوت قطرات تتدفق من المزاريب '
        'القديمة، ووقع خطوات ثقيلة على الحصى المبلل.',
    music:
        'تصاعد خفيف للوتريات العميقة مع إيقاع بطيء يشبه نبض القلب لبناء '
        'الترقب الدرامي.',
    vfx:
        'محاكاة واقعية لحبيبات المطر المضاءة أمام الفانوس، ضباب رطب خفيف في '
        'خلفية الزقاق، وتعزيز تباين الانعكاسات المائية.',
  ),

  // ───────────── المشهد 04 ─────────────
  SceneData(
    number: 4,
    title: 'الرسالة الأخيرة تحت القوس',
    slugline: 'EXT. ANCIENT CITY ARCHWAY ALLEY - RAINY NIGHT',
    timecode: '00:24 — 00:34',
    startSec: 24,
    durationSec: 10,
    description:
        'عند نهاية الزقاق وتحت قوس حجري مقنطر يحميه جزئياً من المطر، يقف '
        'التلميذ الشاب منتظراً في الظل وقد بلل الرذاذ معطفه. يرفع الرحالة '
        'فانوسه ليكشف وجه التلميذ المرهق والمخلص؛ يتبادلان نظرة صامتة تختصر '
        'سنوات من البحث، قبل أن يمد التلميذ يده بالرسالة الأخيرة المختومة '
        'بالشمع الأحمر، ليختتم المشهد بتعانق الضوءين وتوقف الزمن.',
    shotType:
        'لقطة متوسطة ثنائية (Medium Two-Shot) تنتقل إلى لقطة قريبة على اليدين '
        'والرسالة ثم وجه الرحالة',
    cameraMove:
        'اقتراب بطيء جداً ومستقر (Slow Dramatic Push-in) يضيق الكادر نحو لحظة التسليم',
    angle:
        'زاوية جانبية متقابلة بمستوى العين (Eye-Level Profile Two-Shot) لتأكيد '
        'الندية العاطفية',
    lens:
        '75mm Anamorphic · f/1.8 · عزل بصري عميق يبرز الملامح وتفاصيل الختم الشمعي',
    directorNote:
        'استخدام عدسة 75 ملم يضغط المسافة البصرية بين المعلم والتلميذ، محولاً '
        'لحظة تسليم الرسالة إلى ذروة شاعرية حميمية.',
    masterPrompt:
        'Cinematic medium two-shot under a carved ancient stone archway in a '
        'rain-drenched old city alleyway at night, on the left stands a '
        '70-year-old Middle Eastern man with weathered olive skin, deep-set '
        'amber eyes, neatly trimmed silver-white beard, wearing a heavy '
        'charcoal-gray hooded wool cloak soaked on the shoulders over a dark '
        'indigo linen tunic, worn brown leather satchel strapped across his '
        'chest, holding an ornate tarnished brass oil lantern emitting warm '
        'amber light between them; facing him on the right stands a 24-year-old '
        'Middle Eastern young man with sharp dark eyes, short tousled black '
        'hair, light stubble, wearing a rain-dampened dark olive-green canvas '
        'coat over a textured brown wool sweater, extending both hands to offer '
        'a wax-sealed aged parchment envelope, warm golden lantern light '
        'illuminating both faces and the red wax seal against cool blue rain '
        'curtains falling outside the archway, shot on 35mm Kodak Vision3 500T, '
        'ARRI Alexa 35 Atlas Orion Anamorphic 75mm, intimate shallow depth of '
        'field, chiaroscuro lighting',
    motionPrompt:
        'Rain falls steadily outside the stone archway in the background, the '
        'apprentice steps slightly forward from shadow into warm lantern light '
        'extending the wax-sealed letter slowly, the elderly traveler raises '
        'his free hand carefully to receive it while holding their gazes '
        'steady, slow smooth camera push-in toward the letter and their faces.',
    mjParams: '--ar 21:9 --style raw --v 6.1',
    lightingColors:
        'ضوء الفانوس النحاسي يتوسط الشخصيتين مانحاً دفئاً حميمياً لوجهيهما '
        'والختم الأحمر، محاطاً بستائر المطر الزرقاء الداكنة خلف القوس الحجري.',
    wardrobe:
        'الشيخ حكيم بملابسه الصوفية المبللة والفانوس، وسالم بمعطفه القماشي '
        'الزيتوني المبلل بالرذاذ حاملاً الظرف الورقي القديم المختوم بالشمع الأحمر.',
    speaker: 'التلميذ (سالم) ثم الرحالة المسنّ — حوار مباشر خافت (Direct Dialogue)',
    dialogueText:
        'التلميذ: انتظرتك حتى هدأ المطر يا معلمي.. هذه رسالتها الأخيرة قبل الرحيل.\n'
        'الرحالة: وهل بقي في الحبر ما لم تقله النجوم؟',
    tone:
        'صوت التلميذ خافت مبحوح بالاحترام والتأثر، يتبعه رد الرحالة بنبرة '
        'دافئة متأملة تحمل القبول والحكمة.',
    elevenCue:
        '[Speaker 1: quiet earnest young Middle Eastern male, soft breathy '
        'respectful tone, emotional pause] ... [Speaker 2: warm raspy elderly '
        'male voice, calm philosophical acceptance, gentle soft sigh]',
    sfx:
        'هدوء نسبي للمطر تحت القوس الحجري مقارنة بالخارج، حفيف المعطف المبلل، '
        'وصوت ملامسة اليدين للورق الأثري.',
    music:
        'خاتمة موسيقية شاعرية هادئة تجمع التشيلو والبيانو الصامت بنغمة معلقة '
        'تترك أثراً للغموض والتأمل.',
    vfx:
        'توهج دافئ خفيف حول الختم الشمعي الأحمر، بوكيه بيضاوي أنامورفيكي '
        'لقطرات المطر المضاءة في الخلفية، وتلاشي تدريجي ناعم إلى الأسود.',
  ),
];

/// مجموع مدة الفيلم بالثواني.
int get totalDurationSec =>
    projectScenes.fold<int>(0, (int sum, SceneData s) => sum + s.durationSec);
