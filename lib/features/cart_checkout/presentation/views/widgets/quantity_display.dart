import 'package:flutter/material.dart';
import 'package:payment_feature/core/constants/styles/app_text_styles.dart';

class QuantityDisplay extends StatelessWidget {
  final int quantity;

  const QuantityDisplay({super.key, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      child: Text('$quantity', style: AppTextStyles.interRegular18(context)),
    );
  }
}
