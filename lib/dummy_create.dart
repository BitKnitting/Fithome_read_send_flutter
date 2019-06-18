///
//* Create dummy energy readings in Firebase RT
// Used for testing.
///
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'model/energy_entry.dart';

class DummyCreate {
  //
  //* Method creates reading with dummy values in the database.
  //
  createEnergyReading(machineKey, userKey) async {
    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child(machineKey).child(userKey);
    try {
      await reference.push().set(EnergyReading.fromRandom().toJson());
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
