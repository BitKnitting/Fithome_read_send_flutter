//*
//* Pretend to be an energy sensor sending sensor readings to the Firebase RT store.
import 'dart:async';

import 'dummy_create.dart';

class DummySensor {
  int numSecondsBetweenReadings;
  String machineKey;
  String userKey;
  Timer repeatingTimer;
  //* Constructor
  DummySensor(int numSecs, String machineName, String userID) {
    this.numSecondsBetweenReadings = numSecs;
    this.machineKey = machineName;
    this.userKey = userID;
  }
  void start() {
    // Set up a timer to fire every numSeconds...
    // Write callback for timer firing - sends energy reading....

    Duration duration = Duration(seconds: numSecondsBetweenReadings);
    this.repeatingTimer = Timer.periodic(duration, _sendReading);
    _sendReading(this.repeatingTimer);
  }

  void stop() {
    this.repeatingTimer.cancel();
  }

  void _sendReading(Timer timer) {
    DummyCreate().createEnergyReading(this.machineKey, this.userKey);
  }
}
