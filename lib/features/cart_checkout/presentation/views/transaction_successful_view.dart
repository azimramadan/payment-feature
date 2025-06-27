import 'package:flutter/material.dart';
import 'package:payment_feature/core/constants/app_assets.dart';
import 'package:payment_feature/core/constants/styles/app_colors.dart';
import 'package:payment_feature/core/constants/styles/app_text_styles.dart';
import 'package:payment_feature/features/cart_checkout/data/models/order_summary_item.dart';
import 'package:payment_feature/features/cart_checkout/data/models/transaction_summary_model.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/payment_method_selector.dart';

class TransactionSuccessfulView extends StatelessWidget {
  const TransactionSuccessfulView({super.key, required this.transactionInfo});
  final TransactionSummaryModel transactionInfo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Transform.translate(
        offset: Offset(0, -40),
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: EdgeInsets.only(left: 20, right: 20),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.imagesTransactionBackground),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.sizeOf(context).height * 0.095,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Thank you!', style: AppTextStyles.interMedium25(context)),
                const SizedBox(height: 2),
                Text(
                  'Your transaction was successful',
                  style: AppTextStyles.interRegular20(context),
                ),
                Flexible(child: const SizedBox(height: 42)),
                OrderInfoItem(
                  orderSummaryItem: OrderSummaryItem(
                    label: 'Date',
                    value: transactionInfo.date,
                  ),
                ),
                const SizedBox(height: 20),
                OrderInfoItem(
                  orderSummaryItem: OrderSummaryItem(
                    label: 'Time',
                    value: transactionInfo.time,
                  ),
                ),
                const SizedBox(height: 20),
                OrderInfoItem(
                  orderSummaryItem: OrderSummaryItem(
                    label: 'To',
                    value: transactionInfo.recipientName,
                  ),
                ),
                Divider(height: 54, thickness: 1.5, indent: 15, endIndent: 15),
                OrderInfoItem(
                  orderSummaryItem: OrderSummaryItem(
                    label: 'Total',
                    value: '\$${transactionInfo.totalAmount}',
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  height: 65,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Image.asset(
                            transactionInfo.paymentMethodImage,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          transactionInfo.paymentMethod ==
                                  PaymentMethod.paypal.toString()
                              ? 'Completed by PayPal'
                              : 'Completed by Card',
                          style: AppTextStyles.interMedium22(
                            context,
                          ).copyWith(color: AppColors.blackWith50Opacity),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrderInfoItem extends StatelessWidget {
  final OrderSummaryItem orderSummaryItem;

  const OrderInfoItem({super.key, required this.orderSummaryItem});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          orderSummaryItem.label,
          style: orderSummaryItem.label.toLowerCase() == 'total'
              ? AppTextStyles.interSemiBold24(context)
              : AppTextStyles.interRegular18(context),
        ),
        Text(
          orderSummaryItem.value,
          style: orderSummaryItem.label.toLowerCase() == 'total'
              ? AppTextStyles.interSemiBold24(context)
              : AppTextStyles.interSemiBold18(context),
        ),
      ],
    );
  }
}
