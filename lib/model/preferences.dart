import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const String MACHINE_KEY = "machineKey";
  static const String USER_KEY = "userKey";

  static Future<String> getMachineKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String machineKey = prefs.getString(MACHINE_KEY);

    // workaround - simulate a login setting this
    if (machineKey == null) {
      machineKey = "bambi";
    }
    return machineKey;
  }

  static Future<String> getUserKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userKey = prefs.getString(USER_KEY);

    // workaround - simulate a login setting this
    if (userKey == null) {
      userKey = "0090";
    }

    return userKey;
  }
}
