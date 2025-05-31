import 'package:flutter/material.dart';
import 'package:payment_feature/core/constants/styles/app_text_styles.dart';

enum PaymentMethod { stripe, paypal }

class PaymentMethodSelector extends StatefulWidget {
  final PaymentMethod selectedMethod;
  final void Function(PaymentMethod?)? onChanged;

  const PaymentMethodSelector({
    super.key,
    required this.selectedMethod,
    required this.onChanged,
  });

  @override
  State<PaymentMethodSelector> createState() => _PaymentMethodSelectorState();
}

class _PaymentMethodSelectorState extends State<PaymentMethodSelector> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
            ),
            child: RadioListTile<PaymentMethod>(
              title: Text(
                'Stripe',
                style: AppTextStyles.interMedium22(context),
              ),
              value: PaymentMethod.stripe,
              groupValue: widget.selectedMethod,
              onChanged: widget.onChanged,
            ),
          ),
        ),
        Expanded(
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
            ),
            child: RadioListTile<PaymentMethod>(
              title: Text(
                'PayPal',
                style: AppTextStyles.interMedium22(context),
              ),
              value: PaymentMethod.paypal,
              groupValue: widget.selectedMethod,
              onChanged: widget.onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
