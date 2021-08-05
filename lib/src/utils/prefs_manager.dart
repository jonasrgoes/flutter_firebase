import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {
  static const String prefUserDisplayName = "USER_DISPLAY_NAME";

  void setCurrentUserDisplayName(
      SharedPreferences prefs, String displayName) async {
    await prefs.setString(prefUserDisplayName, displayName);
  }

  String? getCurrentUserDisplayName(SharedPreferences prefs) {
    return prefs.getString(prefUserDisplayName);
  }
}
