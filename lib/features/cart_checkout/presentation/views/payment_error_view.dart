import 'package:flutter/material.dart';
import 'package:payment_feature/core/constants/styles/app_colors.dart';
import 'package:payment_feature/core/constants/styles/app_text_styles.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/action_button.dart';

class PaymentErrorView extends StatelessWidget {
  final String errorMessage;
  final String errorType; // 'cancelled', 'error', 'failed'

  const PaymentErrorView({
    super.key,
    required this.errorMessage,
    required this.errorType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment ${errorType == 'cancelled' ? 'Cancelled' : 'Failed'}',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              errorType == 'cancelled'
                  ? Icons.cancel_outlined
                  : Icons.error_outline,
              size: 80,
              color: errorType == 'cancelled' ? Colors.orange : Colors.red,
            ),
            const SizedBox(height: 20),
            Text(
              errorType == 'cancelled' ? 'Payment Cancelled' : 'Payment Failed',
              style: AppTextStyles.interSemiBold24(context),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              errorMessage,
              style: AppTextStyles.interRegular18(context),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.green,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                'Back to Home',
                style: AppTextStyles.interMedium22(context),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                handlePayPalPayment(context);
              },
              child: Text(
                'Try Again',
                style: AppTextStyles.interSemiBold18(
                  context,
                ).copyWith(color: AppColors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
