import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stockquote/src/dashboard/views/dashboard.dart';
import 'package:stockquote/src/splash/presentation/views/splash_screen.dart';
import 'package:stockquote/src/stock/views/stock_info_screen.dart';
import 'package:stockquote/src/watchlist/views/watchlist_screen.dart';

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
    GoRoute(
        path: StockInfoScreen.path,
        builder: (context, state) {
          return StockInfoScreen(symbol: state.uri.queryParameters['symbol'] ?? '',name: state.uri.queryParameters['name'] ?? '',);
        }
    ),
    GoRoute(
        path: WatchlistScreen.path,
        builder: (context, state) {
          return const WatchlistScreen();
        }
    ),
  ],
);