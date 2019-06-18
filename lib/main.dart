// ***************************************************************
//
// Exploration based on Brandon Donnelson's YouTube Video: Flutter -
// Getting data from Firebase: http://bit.ly/2ZpC1gH
//
// ***************************************************************
import 'package:fithome_show_readings_test/model/preferences.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

import 'dummy_sensor.dart';
import 'model/energy_entry.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Show energy readings'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _power;
  double _v1;
  double _v2;
  double _i1;
  double _i2;
  DateTime _dateTime;
  StreamSubscription _subscriptionToReadings;
  // * Initialize sending dummy readings to Firebase RT
  DummySensor sensor = DummySensor(10, 'bambi', '0090');
  @override
  void initState() {
    PowerReading.getReadingStream('bambi', '0090', _updateReadingUI)
        .then((StreamSubscription s) => _subscriptionToReadings = s);
    // * Generate dummy energy readings and send to Firebase RT.
    sensor.start();

    super.initState();
  }

  @override
  void dispose() {
    // * Turn off sending energy readings.
    sensor.stop();
    if (_subscriptionToReadings != null) {
      _subscriptionToReadings.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          _displayReading('V1', '$_v1'),
          _displayReading('V2', '$_v2'),
          _displayReading('I1', '$_i1'),
          _displayReading('I2', '$_i2'),
          _displayReading('Power', '$_power'),
          _displayReading('dateTime', '$_dateTime'),
        ],
      ),
    );
  }

  Widget _displayReading(String name, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(name),
          Text(value),
        ],
      ),
    );
  }

  _updateReadingUI(EnergyReading reading) {
    setState(() {
      _power = reading.power;
      _v1 = reading.v1;
      _v2 = reading.v2;
      _i1 = reading.i1;
      _i2 = reading.i2;
      _dateTime = reading.dateTime;
    });
  }
}

class PowerData {
  final String key;
  var power;
  var timestamp;

  PowerData.fromJson(this.key, Map data) {
    power = data['P'];
    timestamp = data['timestamp'];
    var date = DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    print(date);
    if (power == null) {
      power = 0;
    }
  }
}

class PowerReading {
  static Future<StreamSubscription<Event>> getReadingStream(String machineName,
      String userID, void onData(EnergyReading reading)) async {
    String machineKey = machineName.length > 2
        ? machineName
        : await Preferences.getMachineKey();
    String userKey =
        userID.length > 2 ? userID : await Preferences.getUserKey();
    StreamSubscription<Event> subscription = FirebaseDatabase.instance
        .reference()
        .child(machineKey)
        .child(userKey)
        .onChildAdded
        .listen((Event event) {
      var reading =
          EnergyReading.fromJson(event.snapshot.key, event.snapshot.value);
      onData(reading);
    });

    return subscription;
  }
}
