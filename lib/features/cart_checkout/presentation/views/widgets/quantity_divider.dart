import 'package:flutter/material.dart';
import 'package:payment_feature/core/constants/styles/app_colors.dart';

class QuantityDivider extends StatelessWidget {
  const QuantityDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(color: AppColors.blackWith50Opacity, width: 1, height: 25);
  }
}
