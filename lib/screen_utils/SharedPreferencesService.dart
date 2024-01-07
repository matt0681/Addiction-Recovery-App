import 'package:shared_preferences/shared_preferences.dart';

// https://isaacadariku.medium.com/storing-and-retrieving-data-in-flutter-with-shared-preferences-in-a-maintainable-way-cf75eed6dbe2

// global private constraints
const String _kDateKey = 'date';
const String _kStatusKey = 'status';

//
class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  static late SharedPreferences _preferences;

  SharedPreferencesService._();

  // Singleton pattern
  static Future<SharedPreferencesService> getInstance() async {
    _instance ??= SharedPreferencesService._();

    _preferences = await SharedPreferences.getInstance();

    return _instance!;
  }

  // Persist and retrieve a date
  String get date => _getData(_kDateKey) ?? '';
  set date(String value) => _saveData(_kDateKey, value);

  // Persist and retrieve a status
  String get status => _getData(_kStatusKey) ?? '';
  set status(String value) => _saveData(_kStatusKey, value);


  // Private generic method for retrieving data from shared preferences
  dynamic _getData(String key) {
    // Retrieve data from shared preferences
    var value = _preferences.get(key);

    // Easily log the data that we retrieve from shared preferences
    print('Retrieved $key: $value');

    // Return the data that we retrieve from shared preferences
    return value;
  }

  // Private method for saving data to shared preferences
  void _saveData(String key, dynamic value) {
    // Easily log the data that we save to shared preferences
    print('Saving $key: $value');

    // Save data to shared preferences
    if (value is String) {
      _preferences.setString(key, value);
    } else if (value is int) {
      _preferences.setInt(key, value);
    } else if (value is double) {
      _preferences.setDouble(key, value);
    } else if (value is bool) {
      _preferences.setBool(key, value);
    } else if (value is List<String>) {
      _preferences.setStringList(key, value);
    }
  }

}

