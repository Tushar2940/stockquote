import 'package:flutter/material.dart';
import 'package:stockquote/core/res/colors/stock_colors.dart';

class StockAppbarTheme{
  StockAppbarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: StockColors.white,
    foregroundColor: StockColors.black,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black, size: 24),
    actionsIconTheme: IconThemeData(color: Colors.black, size: 24),
    titleTextStyle: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black),
  ); // AppBar Theme
  static var darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: StockColors.scaffoldBgColorDark,
    foregroundColor: StockColors.white,
    surfaceTintColor: Colors.transparent,
    iconTheme: const IconThemeData(color: Colors.black, size: 24),
    actionsIconTheme: const IconThemeData(color: Colors.white, size: 24),
    titleTextStyle: const TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),
  ); // AppBarTheme
}