import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';

enum ConfigurationModeEnum { debug, production }

class ApiConfiguration {
// * ========================  change here to switch btw debug and prod.  ======================== *

  static ConfigurationModeEnum configurationMode = kDebugMode
      ? ConfigurationModeEnum.debug
      : ConfigurationModeEnum.production;

//! ==================================================================================================
//! ========================================= Do Not Touch ! =========================================
//! ==================================================================================================
  static bool get isDebugMode =>
      configurationMode == ConfigurationModeEnum.debug;

  static String get baseUrl => isDebugMode ? _debugBaseUrl : _prodBaseUrl;

  //TODO : HERE the url of prod backend !!
  static const String _prodBaseUrl = '';

  static String get _debugBaseUrl =>
      Platform.isAndroid ? _debugBaseUrlAndroid : _debugBaseUrlIOS;

  static const String _debugBaseUrlAndroid =
      'http://10.0.2.2:3000'; // alias localhost

  static const String _debugBaseUrlIOS =
      'http://127.0.0.1:3000'; // alias localhost
}
