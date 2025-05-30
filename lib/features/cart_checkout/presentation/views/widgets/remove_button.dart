import 'package:flutter/material.dart';
import 'package:payment_feature/core/constants/styles/app_colors.dart';
import 'package:payment_feature/core/constants/styles/app_text_styles.dart';

class RemoveButton extends StatelessWidget {
  final VoidCallback onRemove;

  const RemoveButton({super.key, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onRemove,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(Icons.delete_outline, size: 18, color: AppColors.red),
          SizedBox(width: 6),
          Text(
            'Remove',
            style: AppTextStyles.interRegular18(
              context,
            ).copyWith(color: AppColors.red),
          ),
        ],
      ),
    );
  }
}
