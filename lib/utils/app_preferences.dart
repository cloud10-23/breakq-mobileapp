import 'package:shared_preferences/shared_preferences.dart';

/// Providing a persistent store for simple data via [SharedPreferences].
///
/// Access to NSUserDefaults on iOS and SharedPreferences on Android.
class AppPreferences {
  factory AppPreferences() => instance;

  AppPreferences._();

  static final AppPreferences instance = AppPreferences._();

  /// Access to NSUserDefaults on iOS and SharedPreferences on Android.
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  /// Reads a value from persistent storage as a String.
  Future<String> getString(String key) {
    return _sharedPreferences
        .then((SharedPreferences pref) => pref.getString(key) ?? '');
  }

  /// Reads a value from persistent storage as a list of strings
  Future<List<String>> getStringList(String key) {
    return _sharedPreferences
        .then((SharedPreferences pref) => pref.getStringList(key));
  }

  /// Saves a string [value] to persistent storage in the background.
  Future<bool> setString(String key, String value) {
    return _sharedPreferences
        .then((SharedPreferences pref) => pref.setString(key, value));
  }

  /// Saves a list of strings [values] to persistent storage in the background.
  Future<bool> setStringList(String key, List<String> values) {
    return _sharedPreferences
        .then((SharedPreferences pref) => pref.setStringList(key, values));
  }

  /// Saves a boolean [value] to persistent storage in the background.
  Future<bool> setBool(String key, bool value) {
    return _sharedPreferences
        .then((SharedPreferences pref) => pref.setBool(key, value));
  }

  /// Returns true if persistent storage the contains the given [key].
  Future<bool> containsKey(String key) {
    return _sharedPreferences
        .then((SharedPreferences pref) => pref.containsKey(key));
  }

  /// Removes an entry from persistent storage.
  Future<bool> remove(String key) {
    return _sharedPreferences
        .then((SharedPreferences pref) => pref.remove(key));
  }

  /// Completes with true once the user preferences for the app has been cleared.
  Future<bool> clear() {
    return _sharedPreferences.then((SharedPreferences pref) => pref.clear());
  }
}
