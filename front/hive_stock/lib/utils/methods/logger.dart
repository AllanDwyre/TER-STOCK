import 'package:logger/logger.dart';

late Logger logger;

final LogPrinter defaultLogPrinter = PrettyPrinter(
  methodCount: 1,
  errorMethodCount: 5,
  lineLength: 50,
  colors: true,
  printEmojis: true,
  printTime: false,
);
