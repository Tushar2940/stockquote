import 'package:flutter/material.dart';
import 'package:stockquote/core/res/theme/stock_theme.dart';
import 'package:stockquote/core/services/router.dart';
import 'package:toastification/toastification.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Stock Quote',
        routerConfig: router,
        theme: StockTheme.lightTheme,
        darkTheme: StockTheme.darkTheme,
        themeMode: ThemeMode.system,
      ),
    );
  }
}

