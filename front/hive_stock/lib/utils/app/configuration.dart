import 'dart:io' show Platform;

enum ConfigurationModeEnum { debug, production }

class ApiConfiguration {
// * ========================  change here to switch btw debug and prod.  ======================== *

  static ConfigurationModeEnum configurationMode = ConfigurationModeEnum.debug;

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
      'http://192.168.1.102:3000'; // alias localhost
}
