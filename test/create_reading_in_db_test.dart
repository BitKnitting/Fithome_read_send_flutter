import 'package:fithome_show_readings_test/dummy_create.dart';
import 'package:flutter_test/flutter_test.dart';
// Must mock firebase - can't unit test because uses a channel.  Now
// probably could if used firebase core?
void main() {
  group('Create DB entries: ', () {
    test('Create entry', () {
      DummyCreate().createEnergyReading('bambi', '0090');
    });
  });
}
