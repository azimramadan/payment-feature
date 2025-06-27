import 'package:flutter/material.dart';
import 'package:payment_feature/core/constants/styles/app_text_styles.dart';
import 'package:payment_feature/core/shared/data/models/user_model.dart';
import 'package:payment_feature/features/cart_checkout/data/models/order_summary_item.dart';
import 'package:payment_feature/features/cart_checkout/data/models/order_summary_model.dart';
import 'package:payment_feature/features/cart_checkout/data/models/payment_intent_input_model.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/action_button.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/payment_method_selector.dart';

class PaymentSummarySection extends StatefulWidget {
  const PaymentSummarySection({super.key, required this.orderSummaryModel});
  final OrderSummaryModel orderSummaryModel;

  @override
  State<PaymentSummarySection> createState() => _PaymentSummarySectionState();
}

class _PaymentSummarySectionState extends State<PaymentSummarySection> {
  PaymentMethod selectedMethod = PaymentMethod.card;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OrderSummaryRow(
          orderSummaryItem: OrderSummaryItem(
            label: 'Order Subtotal',
            value: '\$${widget.orderSummaryModel.subtotal.toStringAsFixed(2)}',
          ),
        ),
        const SizedBox(height: 3),
        OrderSummaryRow(
          orderSummaryItem: OrderSummaryItem(
            label: 'Discount',
            value: '\$${widget.orderSummaryModel.discount.toStringAsFixed(2)}',
          ),
        ),
        const SizedBox(height: 3),
        OrderSummaryRow(
          orderSummaryItem: OrderSummaryItem(
            label: 'Shipping',
            value: '\$${widget.orderSummaryModel.shipping.toStringAsFixed(2)}',
          ),
        ),
        Divider(height: 30, thickness: 1.5, indent: 15, endIndent: 15),
        OrderSummaryRow(
          orderSummaryItem: OrderSummaryItem(
            label: 'Total',
            value: '\$${widget.orderSummaryModel.total.toStringAsFixed(2)}',
          ),
        ),
        const SizedBox(height: 8),

        PaymentMethodSelector(
          selectedMethod: selectedMethod,
          onChanged: (method) {
            if (method != null) {
              setState(() {
                selectedMethod = method;
              });
            }
          },
        ),
        const SizedBox(height: 4),
        ActionButton(
          paymentIntentInputModel: PaymentIntentInputModel(
            amount: widget.orderSummaryModel.total,
            customer: userModel.stripeCustomerId!,
          ),
          paymentMethod: selectedMethod.toString(),
        ),
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
