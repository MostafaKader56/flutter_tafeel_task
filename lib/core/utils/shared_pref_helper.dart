import 'dart:io';
import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static late final SharedPreferences prefs;
  static bool _isPrefInitialized = false;

  static Future<void> init() async {
    if (_isPrefInitialized) {
      return;
    }
    prefs = await SharedPreferences.getInstance().then((value) {
      _isPrefInitialized = true;
      return value;
    });
    // if (!SharedPrefsHelper.isContainsDeviceData()) {}
  }

  // Keys
  static const String _appLanguageKey = '_appLanguageKey';
  static const String _isOnboardingViewedKey = '_isOnboardingViewedKey';
  static const String _isDarkModeKey = '_isDarkModeKey';

  static Future<void> setLanguageSuffix(String languageCode) async {
    await prefs.setString(_appLanguageKey, languageCode);
  }

  static String getLanguageSuffix() {
    return prefs.getString(_appLanguageKey) ??
        Intl.shortLocale(Platform.localeName);
  }

  static Future<void> setOnboardingViewed(bool isViewed) async {
    await prefs.setBool(_isOnboardingViewedKey, isViewed);
  }

  static bool isOnboardingViewed() {
    return prefs.getBool(_isOnboardingViewedKey) ?? false;
  }

  static Future<void> setIsDarkMode(bool isDarkMode) async {
    await prefs.setBool(_isDarkModeKey, isDarkMode);
  }

  static bool getIsDarkMode() {
    return prefs.getBool(_isDarkModeKey) ??
        (PlatformDispatcher.instance.platformBrightness == Brightness.dark);
  }
}
