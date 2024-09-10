import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stockquote/src/dashboard/views/dashboard.dart';
import 'package:stockquote/src/splash/presentation/views/splash_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
        builder: (context, state) {
          return const SplashScreen();
        }
    ),
    GoRoute(
        path: Dashboard.path,
        builder: (context, state) {
          return const Dashboard();
        }
    ),
  ],
);