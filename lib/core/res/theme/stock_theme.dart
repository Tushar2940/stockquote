
import 'package:flutter/material.dart';
import 'package:stockquote/core/res/colors/stock_colors.dart';
import 'package:stockquote/core/res/theme/stock_appbar_theme.dart';
import 'package:stockquote/core/res/theme/stock_text_form_field_theme.dart';
import 'package:stockquote/core/res/theme/stock_text_theme.dart';

class StockTheme{
  const StockTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: StockColors.primaryColor,
    scaffoldBackgroundColor: StockColors.white,
    textTheme: StockTextTheme.lightTextTheme,
    inputDecorationTheme: StockTextFormFieldTheme.lightInputDecorationTheme,
    appBarTheme: StockAppbarTheme.lightAppBarTheme,
  );
  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      primaryColor: StockColors.primaryColor,
      scaffoldBackgroundColor: StockColors.scaffoldBgColorDark,
      textTheme: StockTextTheme.darkTextTheme,
      inputDecorationTheme: StockTextFormFieldTheme.darkInputDecorationTheme,
      appBarTheme: StockAppbarTheme.darkAppBarTheme,
  );
}