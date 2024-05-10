import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_stock/utils/app/configuration.dart';
import 'package:hive_stock/utils/constants/boxes_hive.dart';
import 'package:hive_stock/utils/methods/logger.dart';
import 'package:logger/logger.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  secureStorage = const FlutterSecureStorage();

  logger = Logger(printer: defaultLogPrinter);

  Logger.level = ApiConfiguration.isDebugMode ? Level.trace : Level.error;

  runApp(const App());
}
