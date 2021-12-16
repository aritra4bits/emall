import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  String bearerToken = 'token';
  // String password = 'password';
  String name = 'name';
  String phone = 'phone';
  String icNumber = 'icNumber';
  String firstName = 'firstName';
  String lastName = 'lastName';
  String email = 'email';
  String sex = 'sex';
  String isVerified = 'isVerified';
  String thumbUrl = 'thumbUrl';
  String largeUrl = 'largeUrl';
  String keepUserLoggedIn = 'keepUserLoggedIn';
  String userId = 'userId';
  String notifications = 'notifications';
  String locale = 'locale';
  String quoteId = 'quoteId';

  final Future<SharedPreferences> _storage = SharedPreferences.getInstance();

  Future<String?> getValueByKey(String key) async {
    SharedPreferences storage = await _storage;
    String? value = storage.getString(key);
    return Future.value(value);
  }

  Future<void> setValueByKey(String key, String value) async {
    SharedPreferences storage = await _storage;
    await storage.setString(key, value);
  }

  Future<void> deleteValueByKey(String key) async {
    SharedPreferences storage = await _storage;
    await storage.remove(key);
  }

  Future<void> deleteAllValues() async {
    SharedPreferences storage = await _storage;
    await storage.clear();
  }
}

final Preferences preferences = Preferences();