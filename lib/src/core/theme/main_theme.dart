import 'package:flutter/material.dart';

import '../constants/managers/color_manager.dart';
import '../constants/text_styles/poppins_style.dart';

class AppTheme {
  static final primaryTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFF2F2F2),
    useMaterial3: true,
    inputDecorationTheme: InputDecorationTheme(
      activeIndicatorBorder: BorderSide(color: ColorManager.lightBlue),
      border: OutlineInputBorder(borderSide: BorderSide(color: ColorManager.lightBlue)),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorManager.lightBlue)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorManager.lightBlue)),
      outlineBorder: BorderSide(color: ColorManager.lightBlue),
      contentPadding: EdgeInsets.zero,
      hintStyle: PoppinsStyle.b600.copyWith(color: ColorManager.darkBlue),
      filled: true,
      fillColor: ColorManager.white,
      prefixIconColor: ColorManager.darkBlue,
      suffixIconColor: ColorManager.darkBlue,
    ),
    appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: ColorManager.white)),
  );
}
