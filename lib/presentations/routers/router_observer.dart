import 'package:bookly/core/utils/logger.dart';
import 'package:flutter/material.dart';


class AppRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    logger.info('Navigation vers : ${route.settings.name ?? route.settings.arguments}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    logger.info('Retour depuis : ${route.settings.name ?? route.settings.arguments}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    logger.info('Route supprimée : ${route.settings.name ?? route.settings.arguments}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    logger.info('Route remplacée : ${oldRoute?.settings.name} -> ${newRoute?.settings.name}');
  }
}
