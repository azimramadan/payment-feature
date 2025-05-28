import 'package:flutter/material.dart';
import 'package:payment_feature/core/constants/styles/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();
  static TextStyle interMedium25(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, baseFontSize: 25),
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );

  static TextStyle interRegular18(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, baseFontSize: 18),
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );

  static TextStyle interSemiBold24(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, baseFontSize: 24),
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );
  static TextStyle interMedium22(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, baseFontSize: 22),
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );
  static TextStyle interSemiBold20(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, baseFontSize: 20),
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );
  static TextStyle interSemiBold18(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, baseFontSize: 18),
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );
  static TextStyle interRegular20(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, baseFontSize: 18),
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );
}

double getResponsiveFontSize(
  BuildContext context, {
  required double baseFontSize,
}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = scaleFactor * baseFontSize;
  double lowerLimit = baseFontSize * .8;
  double upperLimit = baseFontSize * 1.2;
  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(BuildContext context) {
  double screenWidth = MediaQuery.sizeOf(context).width;
  if (screenWidth < 800) {
    return screenWidth / 550;
  } else if (screenWidth < 1200) {
    return screenWidth / 1000;
  } else {
    return screenWidth / 1500;
  }
}
