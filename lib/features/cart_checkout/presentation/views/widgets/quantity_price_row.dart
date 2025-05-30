import 'package:flutter/material.dart';
import 'package:payment_feature/core/constants/styles/app_colors.dart';
import 'package:payment_feature/core/constants/styles/app_text_styles.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/quantity_button.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/quantity_display.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/quantity_divider.dart';

class QuantityPriceRow extends StatelessWidget {
  final double price;
  final int currentQuantity;
  final int availableQuantity;
  final Function(int) onQuantityChanged;

  const QuantityPriceRow({
    super.key,
    required this.price,
    required this.currentQuantity,
    required this.availableQuantity,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        QuantityController(
          currentQuantity: currentQuantity,
          availableQuantity: availableQuantity,
          onQuantityChanged: onQuantityChanged,
        ),
        Spacer(),
        Text(
          '\$${(price * currentQuantity).toStringAsFixed(2)}',
          style: AppTextStyles.interSemiBold20(context),
        ),
      ],
    );
  }
}

class QuantityController extends StatelessWidget {
  final int currentQuantity;
  final int availableQuantity;
  final Function(int) onQuantityChanged;

  const QuantityController({
    super.key,
    required this.currentQuantity,
    required this.availableQuantity,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: AppColors.black, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          QuantityButton(
            icon: Icons.remove,
            isEnabled: currentQuantity > 0,
            onTap: () => onQuantityChanged(currentQuantity - 1),
          ),
          QuantityDivider(),
          QuantityDisplay(quantity: currentQuantity),
          QuantityDivider(),
          QuantityButton(
            icon: Icons.add,
            isEnabled: currentQuantity < availableQuantity,
            onTap: () => onQuantityChanged(currentQuantity + 1),
          ),
        ],
      ),
    );
  }
}
