import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:stockquote/core/res/theme/stock_theme.dart';
import 'package:stockquote/core/services/router.dart';
import 'package:stockquote/src/watchlist/bloc/watch_list_bloc.dart';
import 'package:toastification/toastification.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WatchListBloc(),
      lazy: false,
      child: ToastificationWrapper(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Stock Quote',
          routerConfig: router,
          theme: StockTheme.lightTheme,
          darkTheme: StockTheme.darkTheme,
          themeMode: ThemeMode.system,
        ),
      ),
    );
  }
}

