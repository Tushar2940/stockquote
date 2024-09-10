import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stockquote/core/res/colors/stock_colors.dart';
import 'package:stockquote/core/res/media/stock_media.dart';
import 'package:stockquote/src/dashboard/views/dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const path = '/splashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(const Duration(seconds: 3),() => context.go(Dashboard.path),);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(StockMedia.appLogo),
          SizedBox(
              width: 100,
              child: LinearProgressIndicator(color: StockColors.primaryColor,borderRadius: BorderRadius.circular(16),))
        ],
      ),
    );
  }
}
