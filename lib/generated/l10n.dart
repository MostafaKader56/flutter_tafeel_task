// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `اللغة العربية`
  String get otherlanguage {
    return Intl.message(
      'اللغة العربية',
      name: 'otherlanguage',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get onboarding1Title {
    return Intl.message(
      'Welcome',
      name: 'onboarding1Title',
      desc: '',
      args: [],
    );
  }

  /// `Discover a smarter way to stay organized and connected.`
  String get onboarding1Description {
    return Intl.message(
      'Discover a smarter way to stay organized and connected.',
      name: 'onboarding1Description',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get onboarding2Title {
    return Intl.message(
      'Get Started',
      name: 'onboarding2Title',
      desc: '',
      args: [],
    );
  }

  /// `Create your profile and set your preferences in just a few taps.`
  String get onboarding2Description {
    return Intl.message(
      'Create your profile and set your preferences in just a few taps.',
      name: 'onboarding2Description',
      desc: '',
      args: [],
    );
  }

  /// `Stay Organized`
  String get onboarding3Title {
    return Intl.message(
      'Stay Organized',
      name: 'onboarding3Title',
      desc: '',
      args: [],
    );
  }

  /// `Keep all your tasks and reminders in one convenient place.`
  String get onboarding3Description {
    return Intl.message(
      'Keep all your tasks and reminders in one convenient place.',
      name: 'onboarding3Description',
      desc: '',
      args: [],
    );
  }

  /// `Connect & Share`
  String get onboarding4Title {
    return Intl.message(
      'Connect & Share',
      name: 'onboarding4Title',
      desc: '',
      args: [],
    );
  }

  /// `Share updates and collaborate with friends and colleagues.`
  String get onboarding4Description {
    return Intl.message(
      'Share updates and collaborate with friends and colleagues.',
      name: 'onboarding4Description',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get onboarding5Title {
    return Intl.message(
      'Notifications',
      name: 'onboarding5Title',
      desc: '',
      args: [],
    );
  }

  /// `Enable notifications to never miss important updates.`
  String get onboarding5Description {
    return Intl.message(
      'Enable notifications to never miss important updates.',
      name: 'onboarding5Description',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message('Get Started', name: 'getStarted', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Tafeel`
  String get app_name {
    return Intl.message('Tafeel', name: 'app_name', desc: '', args: []);
  }

  /// `Users Data`
  String get splash_subtitle {
    return Intl.message(
      'Users Data',
      name: 'splash_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `An unexpected error occurred. Please try again.`
  String get unexpectedError {
    return Intl.message(
      'An unexpected error occurred. Please try again.',
      name: 'unexpectedError',
      desc: '',
      args: [],
    );
  }

  /// `Language Settings`
  String get languageSettings {
    return Intl.message(
      'Language Settings',
      name: 'languageSettings',
      desc: '',
      args: [],
    );
  }

  /// `Choose Your Language`
  String get chooseYourLanguage {
    return Intl.message(
      'Choose Your Language',
      name: 'chooseYourLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Select your preferred language for the best\nexperience`
  String get languageDescription {
    return Intl.message(
      'Select your preferred language for the best\nexperience',
      name: 'languageDescription',
      desc: '',
      args: [],
    );
  }

  /// `English language`
  String get englishSubtitle {
    return Intl.message(
      'English language',
      name: 'englishSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Arabic language`
  String get arabicSubtitle {
    return Intl.message(
      'Arabic language',
      name: 'arabicSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Users`
  String get users {
    return Intl.message('Users', name: 'users', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `English`
  String get selectedLanguage {
    return Intl.message(
      'English',
      name: 'selectedLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Dark Theme`
  String get darkTheme {
    return Intl.message('Dark Theme', name: 'darkTheme', desc: '', args: []);
  }

  /// `Switch to dark mode`
  String get darkThemeDescription {
    return Intl.message(
      'Switch to dark mode',
      name: 'darkThemeDescription',
      desc: '',
      args: [],
    );
  }

  /// `No users found`
  String get noUsersFound {
    return Intl.message(
      'No users found',
      name: 'noUsersFound',
      desc: '',
      args: [],
    );
  }

  /// `There are no users to display`
  String get noUsersFoundDescription {
    return Intl.message(
      'There are no users to display',
      name: 'noUsersFoundDescription',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get refresh {
    return Intl.message('Refresh', name: 'refresh', desc: '', args: []);
  }

  /// `Failed to load users`
  String get failedToLoadUsers {
    return Intl.message(
      'Failed to load users',
      name: 'failedToLoadUsers',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load more users`
  String get failedToLoadMoreUsers {
    return Intl.message(
      'Failed to load more users',
      name: 'failedToLoadMoreUsers',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `First Name`
  String get firstName {
    return Intl.message('First Name', name: 'firstName', desc: '', args: []);
  }

  /// `Last Name`
  String get lastName {
    return Intl.message('Last Name', name: 'lastName', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `User Profile`
  String get userProfile {
    return Intl.message(
      'User Profile',
      name: 'userProfile',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
