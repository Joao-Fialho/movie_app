import 'package:flutter/material.dart';

import '../app_colors.dart';
import 'app_bar_theme.dart';
import 'app_text_theme.dart';

ThemeData get appTheme => ThemeData(
      backgroundColor: AppColors.backgroundColor,
      primaryColor: AppColors.activeFilterButtonColor,
      textTheme: appTextTheme,
      appBarTheme: appBarTheme,
      colorScheme: const ColorScheme(
        secondary: AppColors.scoreColor,
        primary: AppColors.activeFilterButtonColor,
        onSecondary: AppColors.activeFavoriteIconColor,
        onPrimary: AppColors.iconsPrimaryColor,
        background: AppColors.backgroundColor,
        onSurface: AppColors.onSurface,
        onBackground: AppColors.iconsPrimaryColor,
        surface: AppColors.cardTitlePrimaryColor,
        error: AppColors.errorColor,
        brightness: Brightness.dark,
        onError: AppColors.errorColor,
      ),

      // textTheme: ,
    );
