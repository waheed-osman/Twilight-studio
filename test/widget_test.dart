import 'package:flutter_test/flutter_test.dart';

import 'package:twilight_chart/data/project_data.dart';
import 'package:twilight_chart/models/story_models.dart';
import 'package:twilight_chart/services/exporter.dart';

void main() {
  test('scene timecodes are contiguous and total 34 seconds', () {
    int cursor = 0;
    for (final scene in projectScenes) {
      expect(scene.startSec, cursor);
      cursor += scene.durationSec;
    }
    expect(totalDurationSec, 34);
  });

  test('countWords handles Arabic, empty and extra spaces', () {
    expect(countWords(''), 0);
    expect(countWords('   '), 0);
    expect(countWords('كان يا ما كان'), 4);
    expect(countWords('a  b\nc'), 3);
  });

  test('story models survive a JSON round trip', () {
    final c = StoryCharacter(name: 'سالم', goal: 'تسليم الرسالة');
    final back = StoryCharacter.fromJson(c.toJson());
    expect(back.id, c.id);
    expect(back.name, 'سالم');
    expect(back.goal, 'تسليم الرسالة');
  });

  test('exporter includes every scene', () {
    final script = buildFullScript();
    for (final scene in projectScenes) {
      expect(script.contains(scene.title), isTrue);
    }
  });
}
