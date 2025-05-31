import 'package:flutter/material.dart';
import 'package:payment_feature/core/constants/styles/app_colors.dart';

class BasketItem extends StatelessWidget {
  const BasketItem({
    super.key,
    required this.imageSize,
    required this.imagePath,
    required this.isSeclected,
  });

  final bool isSeclected;
  final double imageSize;
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: isSeclected
            ? Border.all(color: AppColors.skyBlue, width: 3)
            : null,
        boxShadow: [
          BoxShadow(
            color: isSeclected ? AppColors.darkGray : Colors.transparent,
            blurRadius: isSeclected ? 8 : 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          imagePath,
          width: imageSize,
          height: imageSize,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
