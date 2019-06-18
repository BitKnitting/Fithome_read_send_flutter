import 'dart:math';

import 'package:firebase_database/firebase_database.dart';

class EnergyReading {
  String key;
  double v1;
  double v2;
  double i1;
  double i2;
  double power;
  DateTime dateTime;

  EnergyReading(this.v1, this.v2, this.i1, this.i2, this.power);
  EnergyReading.fromRandom();
  //* Get a reading.
  EnergyReading.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        v1 = snapshot.value["V1"].toDouble(),
        v2 = snapshot.value["V2"].toDouble(),
        i1 = snapshot.value["I1"].toDouble(),
        i2 = snapshot.value["I2"].toDouble(),
        power = snapshot.value["P"].toDouble(),
        dateTime = DateTime.fromMicrosecondsSinceEpoch(
            snapshot.value["timestamp"] * 1000);
  EnergyReading.fromJson(this.key, Map data) {
    v1 = data["V1"];
    v2 = data["V2"];
    i1 = data["I1"];
    i2 = data["I2"];
    power = data["P"];
    dateTime = DateTime.fromMicrosecondsSinceEpoch(data["timestamp"] * 1000);
  }
  //* Create a dummy entry.  Firebase's set() API takes in JSON format.
  toJson() {
    return {
      "V1": _getVoltage(),
      "V2": _getVoltage(),
      "I1": _getCurrent(),
      "I2": _getCurrent(),
      "P": _getPower(),
      "timestamp": {".sv": "timestamp"}
    };
  }

  double _getVoltage() {
    return _getRandom(98.0, 129.0);
  }

  double _getCurrent() {
    return _getRandom(0.1, 10.0);
  }

  double _getPower() {
    return _getRandom(500.0, 1780.0);
  }

  double _getRandom(double min, double max) {
    Random random = Random();
    double range = max - min;
    double scaled = random.nextDouble() * range;
    double shifted = scaled + min;
    // Return a double with 2 decimals.
    int fac = pow(10, 2);
    shifted = (shifted * fac).round() / fac;
    return shifted;
  }
}
