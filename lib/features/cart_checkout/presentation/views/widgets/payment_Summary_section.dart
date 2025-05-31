import 'package:flutter/material.dart';
import 'package:payment_feature/core/constants/styles/app_text_styles.dart';
import 'package:payment_feature/features/cart_checkout/data/models/order_summary_item.dart';
import 'package:payment_feature/features/cart_checkout/data/models/order_summary_model.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/action_button.dart';

class PaymentSummarySection extends StatelessWidget {
  const PaymentSummarySection({super.key, required this.orderSummaryModel});
  final OrderSummaryModel orderSummaryModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OrderSummaryRow(
          orderSummaryItem: OrderSummaryItem(
            label: 'Order Subtotal',
            value: '\$${orderSummaryModel.subtotal.toStringAsFixed(2)}',
          ),
        ),
        const SizedBox(height: 3),
        OrderSummaryRow(
          orderSummaryItem: OrderSummaryItem(
            label: 'Discount',
            value: '\$${orderSummaryModel.discount.toStringAsFixed(2)}',
          ),
        ),
        const SizedBox(height: 3),
        OrderSummaryRow(
          orderSummaryItem: OrderSummaryItem(
            label: 'Shipping',
            value: '\$${orderSummaryModel.shipping.toStringAsFixed(2)}',
          ),
        ),
        Divider(height: 30, thickness: 1.5, indent: 15, endIndent: 15),
        OrderSummaryRow(
          orderSummaryItem: OrderSummaryItem(
            label: 'Total',
            value: '\$${orderSummaryModel.total.toStringAsFixed(2)}',
          ),
        ),
        const SizedBox(height: 16),
        ActionButton(),
        const SizedBox(height: 12),
      ],
    );
  }
}

class OrderSummaryRow extends StatelessWidget {
  final OrderSummaryItem orderSummaryItem;

  const OrderSummaryRow({super.key, required this.orderSummaryItem});

  @override
  Widget build(BuildContext context) {
    var style = (orderSummaryItem.label.toLowerCase() == 'total')
        ? AppTextStyles.interSemiBold24(context)
        : AppTextStyles.interRegular18(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(orderSummaryItem.label, style: style),
        Text(orderSummaryItem.value, style: style),
      ],
    );
  }
}
