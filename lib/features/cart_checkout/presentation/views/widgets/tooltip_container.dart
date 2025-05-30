import 'package:flutter/material.dart';
import 'package:payment_feature/core/constants/styles/app_colors.dart';
import 'package:payment_feature/core/constants/styles/app_text_styles.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/quantity_price_row.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/remove_button.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/stock_warning_widget.dart';

class TooltipContainer extends StatelessWidget {
  final String productName;
  final double price;
  final int currentQuantity;
  final int availableQuantity;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const TooltipContainer({
    super.key,
    required this.productName,
    required this.price,
    required this.currentQuantity,
    required this.availableQuantity,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 230,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.lightGray3,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackWith50Opacity,
              blurRadius: 20,
              spreadRadius: 0,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              productName,
              style: AppTextStyles.interRegular18(context),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 16),
            QuantityPriceRow(
              price: price,
              currentQuantity: currentQuantity,
              availableQuantity: availableQuantity,
              onQuantityChanged: onQuantityChanged,
            ),
            SizedBox(height: 16),
            StockWarningWidget(
              currentQuantity: currentQuantity,
              availableQuantity: availableQuantity,
            ),
            Divider(
              color: AppColors.blackWith50Opacity,
              thickness: .5,
              height: 1,
            ),
            SizedBox(height: 12),
            RemoveButton(onRemove: onRemove),
          ],
        ),
      ),
    );
  }
}
