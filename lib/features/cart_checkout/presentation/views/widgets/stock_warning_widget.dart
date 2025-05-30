import 'package:flutter/material.dart';
import 'package:payment_feature/core/constants/styles/app_colors.dart';
import 'package:payment_feature/core/constants/styles/app_text_styles.dart';

class StockWarningWidget extends StatelessWidget {
  final int currentQuantity;
  final int availableQuantity;

  const StockWarningWidget({
    super.key,
    required this.currentQuantity,
    required this.availableQuantity,
  });

  @override
  Widget build(BuildContext context) {
    if (currentQuantity < availableQuantity) {
      return SizedBox.shrink();
    }

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning_amber_outlined,
              size: 18,
              color: AppColors.orange,
            ),
            SizedBox(width: 6),
            Text(
              currentQuantity == 0 ? 'Out of stock' : 'There is no more',
              style: AppTextStyles.interRegular18(
                context,
              ).copyWith(color: AppColors.orange),
            ),
          ],
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
