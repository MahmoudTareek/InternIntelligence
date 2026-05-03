import 'package:shared_preferences/shared_preferences.dart';

class SubscriptionManager {
  static const String _isSubscribedKey = 'isSubscribed';

  static Future<bool> isSubscribed() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isSubscribedKey) ?? false;
  }

  static Future<void> subscribe() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isSubscribedKey, true);
  }

  static Future<void> unsubscribe() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isSubscribedKey, false);
  }
}
