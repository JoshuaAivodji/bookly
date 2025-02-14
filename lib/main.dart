import 'package:bookly/presentations/pages/app_init_page.dart';
import 'package:flutter/material.dart';

import 'core/services/init_app_service.dart';
import 'core/utils/logger.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*FlutterError.onError = (FlutterErrorDetails details) {
      FirebaseCrashlytics.instance.recordFlutterError(details);
      FlutterError.dumpErrorToConsole(details);
      Zone.current.handleUncaughtError(details.exception, details.stack!);
    };*/

  await initAppServices();

  logger.runLogging(() {
    runApp(const AppInitPage());
  }, const LogOptions(
    coloredOutput: true,
    level: LoggerLevel.verbose,
  ));

}

