/// نموذج الشخصية.
class CharacterData {
  const CharacterData({
    required this.nameAr,
    required this.nameEn,
    required this.role,
    required this.voiceProfile,
    required this.visualAnchor,
  });

  final String nameAr;
  final String nameEn;
  final String role;
  final String voiceProfile;
  final String visualAnchor;
}

/// نموذج المشهد السينمائي بكل عناصره.
class SceneData {
  const SceneData({
    required this.number,
    required this.title,
    required this.slugline,
    required this.timecode,
    required this.startSec,
    required this.durationSec,
    required this.description,
    required this.shotType,
    required this.cameraMove,
    required this.angle,
    required this.lens,
    required this.directorNote,
    required this.masterPrompt,
    required this.motionPrompt,
    required this.mjParams,
    required this.lightingColors,
    required this.wardrobe,
    required this.speaker,
    required this.dialogueText,
    required this.tone,
    required this.elevenCue,
    required this.sfx,
    required this.music,
    required this.vfx,
  });

  final int number;
  final String title;
  final String slugline;
  final String timecode;
  final int startSec;
  final int durationSec;
  final String description;

  // الكادرات
  final String shotType;
  final String cameraMove;
  final String angle;
  final String lens;
  final String directorNote;

  // البروميتات
  final String masterPrompt;
  final String motionPrompt;
  final String mjParams;
  final String lightingColors;
  final String wardrobe;

  // الصوت
  final String speaker;
  final String dialogueText;
  final String tone;
  final String elevenCue;

  // المؤثرات
  final String sfx;
  final String music;
  final String vfx;

  String get numberLabel => number.toString().padLeft(2, '0');

  /// نص موحّد يُستخدم في البحث.
  String get searchText => [
        title,
        slugline,
        description,
        dialogueText,
        speaker,
        lightingColors,
      ].join(' ');
}
