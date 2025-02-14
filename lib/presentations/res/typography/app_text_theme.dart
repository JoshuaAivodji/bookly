import 'package:bookly/presentations/res/app_colors.dart';
import 'package:flutter/material.dart';

import 'app_text_style.dart';

class AppTextTheme {

  static TextTheme lightTextTheme() => TextTheme(
    displayLarge: AppTextStyle.title2x24.copyWith(color: AppColors.lightText),
    displayMedium: AppTextStyle.title1x20.copyWith(color: AppColors.lightText),
    titleLarge: AppTextStyle.barTitle20.copyWith(color: AppColors.lightText),
    bodyLarge: AppTextStyle.textRegular14.copyWith(color: AppColors.lightText),
    bodyMedium: AppTextStyle.textRegular13.copyWith(color: AppColors.lightText),
    labelLarge: AppTextStyle.labelBold18.copyWith(color: AppColors.lightText),
    labelMedium: AppTextStyle.labelMedium16.copyWith(color: AppColors.lightText),
    labelSmall: AppTextStyle.subtitleRegular12.copyWith(color: AppColors.lightText),
  );

  static TextTheme darkTextTheme() => TextTheme(
    displayLarge: AppTextStyle.title2x24.copyWith(color: AppColors.darkText),
    displayMedium: AppTextStyle.title1x20.copyWith(color: AppColors.darkText),
    titleLarge: AppTextStyle.barTitle20.copyWith(color: AppColors.darkText),
    bodyLarge: AppTextStyle.textRegular14.copyWith(color: AppColors.darkText),
    bodyMedium: AppTextStyle.textRegular13.copyWith(color: AppColors.darkText),
    labelLarge: AppTextStyle.labelBold18.copyWith(color: AppColors.darkText),
    labelMedium: AppTextStyle.labelMedium16.copyWith(color: AppColors.darkText),
    labelSmall: AppTextStyle.subtitleRegular12.copyWith(color: AppColors.darkText),
  );

}
