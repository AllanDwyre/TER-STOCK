import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_stock/utils/app/bridge_repository.dart';
import 'package:hive_stock/utils/app/configuration.dart';
import 'package:hive_stock/utils/constants/boxes_hive.dart';
import 'package:hive_stock/utils/methods/logger.dart';
import 'package:logger/logger.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  secureStorage = const FlutterSecureStorage(
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );
  BridgeController.bridgeInitialization();

  logger = Logger(printer: defaultLogPrinter);

  Logger.level = ApiConfiguration.isDebugMode ? Level.trace : Level.error;

  // Bloc.observer = const SimpleBlocObserver(); // * https://bloclibrary.dev/bloc-concepts/#blocobserver
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    if (kReleaseMode) exit(1);
  };
  runApp(const App());
}
