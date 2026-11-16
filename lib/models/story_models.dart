/// معرّف فريد بسيط يعتمد على الوقت.
String newId() => DateTime.now().microsecondsSinceEpoch.toString();

String _s(dynamic value) => value is String ? value : '';

/// فكرة القصة الأساسية.
class StoryProject {
  StoryProject({
    this.title = '',
    this.genre = '',
    this.logline = '',
    this.premise = '',
    this.theme = '',
    this.tone = '',
    this.pov = '',
    this.setting = '',
    this.structureId = 'three_act',
  });

  String title;
  String genre;
  String logline;
  String premise;
  String theme;
  String tone;
  String pov;
  String setting;
  String structureId;

  bool get isEmpty =>
      title.trim().isEmpty && logline.trim().isEmpty && premise.trim().isEmpty;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'genre': genre,
        'logline': logline,
        'premise': premise,
        'theme': theme,
        'tone': tone,
        'pov': pov,
        'setting': setting,
        'structureId': structureId,
      };

  factory StoryProject.fromJson(Map<String, dynamic> json) {
    final String structure = _s(json['structureId']);
    return StoryProject(
      title: _s(json['title']),
      genre: _s(json['genre']),
      logline: _s(json['logline']),
      premise: _s(json['premise']),
      theme: _s(json['theme']),
      tone: _s(json['tone']),
      pov: _s(json['pov']),
      setting: _s(json['setting']),
      structureId: structure.isEmpty ? 'three_act' : structure,
    );
  }
}

/// شخصية في القصة.
class StoryCharacter {
  StoryCharacter({
    String? id,
    this.name = '',
    this.role = '',
    this.goal = '',
    this.need = '',
    this.flaw = '',
    this.wound = '',
    this.arc = '',
    this.voice = '',
    this.notes = '',
  }) : id = id ?? newId();

  final String id;
  String name;
  String role;
  String goal;
  String need;
  String flaw;
  String wound;
  String arc;
  String voice;
  String notes;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'role': role,
        'goal': goal,
        'need': need,
        'flaw': flaw,
        'wound': wound,
        'arc': arc,
        'voice': voice,
        'notes': notes,
      };

  factory StoryCharacter.fromJson(Map<String, dynamic> json) {
    final String id = _s(json['id']);
    return StoryCharacter(
      id: id.isEmpty ? null : id,
      name: _s(json['name']),
      role: _s(json['role']),
      goal: _s(json['goal']),
      need: _s(json['need']),
      flaw: _s(json['flaw']),
      wound: _s(json['wound']),
      arc: _s(json['arc']),
      voice: _s(json['voice']),
      notes: _s(json['notes']),
    );
  }
}

/// فصل من فصول القصة.
class Chapter {
  Chapter({
    String? id,
    this.title = '',
    this.summary = '',
    this.content = '',
  }) : id = id ?? newId();

  final String id;
  String title;
  String summary;
  String content;

  int get wordCount => countWords(content);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'summary': summary,
        'content': content,
      };

  factory Chapter.fromJson(Map<String, dynamic> json) {
    final String id = _s(json['id']);
    return Chapter(
      id: id.isEmpty ? null : id,
      title: _s(json['title']),
      summary: _s(json['summary']),
      content: _s(json['content']),
    );
  }
}

/// عدّاد كلمات يعمل مع العربية والإنجليزية.
int countWords(String text) {
  final String trimmed = text.trim();
  if (trimmed.isEmpty) {
    return 0;
  }
  return trimmed.split(RegExp(r'\s+')).length;
}
