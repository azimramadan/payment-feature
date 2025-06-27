import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:payment_feature/core/constants/styles/app_colors.dart';
import 'package:payment_feature/core/constants/styles/app_text_styles.dart';
import 'package:payment_feature/features/cart_checkout/data/models/payment_intent_input_model.dart';
import 'package:payment_feature/features/cart_checkout/data/models/transaction_summary_model.dart';
import 'package:payment_feature/features/cart_checkout/presentation/view_models/checkout_cubit/checkout_cubit.dart';
import 'package:payment_feature/features/cart_checkout/presentation/view_models/product_cubit/product_cubit_cubit.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/payment_error_view.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/transaction_successful_view.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/payment_method_selector.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.paymentIntentInputModel,
    required this.paymentMethod,
  });
  final PaymentIntentInputModel paymentIntentInputModel;
  final String paymentMethod;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckoutCubit, CheckoutState>(
      listener: (context, state) {
        if (state is CheckoutFailure) {
          showSnackBar(context, state.message);
        } else if (state is CheckoutSuccess) {
          BlocProvider.of<ProductCubitCubit>(
            context,
          ).updateAvailableQuantities();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => TransactionSuccessfulView(
                transactionInfo: state.transactionSummaryModel,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            if (paymentIntentInputModel.amount == 0) {
              showSnackBar(
                context,
                'Your cart is empty. Please add items before checking out.',
              );
            } else {
              if (paymentMethod == PaymentMethod.card.toString()) {
                BlocProvider.of<CheckoutCubit>(
                  context,
                ).makePayment(paymentIntentInputModel: paymentIntentInputModel);
              } else {
                handlePayPalPayment(context);
              }
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.green,
            minimumSize: const Size(double.infinity, 65),
            maximumSize: const Size(double.infinity, 65),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: state is CheckoutLoading
              ? const CircularProgressIndicator()
              : Text(
                  'Complete Payment',
                  style: AppTextStyles.interMedium22(context),
                ),
        );
      },
    );
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Expanded(child: Text(message)),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white, size: 20),
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
      backgroundColor: Colors.red,
      duration: const Duration(days: 365),
    ),
  );
}

handlePayPalPayment(BuildContext context) {
  final clientId = dotenv.env['CLIENT_ID_PAYPAL'];
  final secretKey = dotenv.env['SECRET_kEY_PAYPAL'];
  var transactions = BlocProvider.of<ProductCubitCubit>(context).transactions;
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckoutView(
        sandboxMode: true,
        clientId: clientId,
        secretKey: secretKey,
        transactions: [transactions.toJson()],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          BlocProvider.of<ProductCubitCubit>(
            context,
          ).updateAvailableQuantities();
          log("onSuccess: $params");
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) {
                return TransactionSuccessfulView(
                  transactionInfo: TransactionSummaryModel(
                    recipientName: 'Abdelazim Ramadan',
                    totalAmount: transactions.amount?.total ?? '0.00',
                    paymentMethod: PaymentMethod.paypal.toString(),
                  ),
                );
              },
            ),
            (route) => route.isFirst,
          );
        },
        onError: (error) {
          log("onError: ${error.toString()}");
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PaymentErrorView(
                  errorMessage: error.toString(),
                  errorType: 'error',
                );
              },
            ),
            (route) => route.isFirst,
          );
        },

        onCancel: () {
          log('cancelled:');
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PaymentErrorView(
                  errorMessage: 'Payment cancelled by user.',
                  errorType: 'cancelled',
                );
              },
            ),
            (route) => route.isFirst,
          );
        },
      ),
    ),
  );
}
