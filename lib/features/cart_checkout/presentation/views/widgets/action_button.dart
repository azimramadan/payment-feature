import 'package:flutter/material.dart';
import 'package:payment_feature/core/constants/styles/app_colors.dart';
import 'package:payment_feature/core/constants/styles/app_text_styles.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/transaction_successful_view.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => TransactionSuccessfulView()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.green,
        minimumSize: const Size(double.infinity, 65),
        maximumSize: const Size(double.infinity, 65),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Text(
        'Complete Payment',
        style: AppTextStyles.interMedium22(context),
      ),
    );
  }
}
