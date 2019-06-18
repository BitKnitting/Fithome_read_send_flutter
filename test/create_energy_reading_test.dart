import 'package:fithome_show_readings_test/model/energy_entry.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Reading Values: ', () {
    test('Random Voltage for V1 is between 98.0 and 129.0', () {

      var r = EnergyReading.fromRandom().toJson();
      bool inRange = (r["V1"] >= 98.0) && (r["V1"] <= 129.0);
      print("====>V1 = ${r["V1"]}");
      expect(inRange, true);
    });
    test('Random Voltage for V2 is between 98.0 and 129.0', () {
      var r = EnergyReading.fromRandom().toJson();
      bool inRange = (r["V2"] >= 98.0) && (r["V2"] <= 129.0);
      print("====>V2 = ${r["V2"]}");
      expect(inRange, true);
    });
    test('Random Current for I1 is between 0.1 and 10.0', () {
      var r = EnergyReading.fromRandom().toJson();
      bool inRange = (r["I1"] >= 0.1) && (r["I1"] <= 10.0);
      print("====>I1 = ${r["I1"]}");
      expect(inRange, true);
    });
    test('Random Current for I2 is between 0.1 and 10.0', () {
      var r = EnergyReading.fromRandom().toJson();
      bool inRange = (r["I2"] >= 0.1) && (r["I2"] <= 10.0);
      print("====>I2 = ${r["I2"]}");
      expect(inRange, true);
    });
  });
}
