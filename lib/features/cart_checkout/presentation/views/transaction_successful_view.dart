import 'package:flutter/material.dart';
import 'package:payment_feature/core/constants/app_assets.dart';
import 'package:payment_feature/core/constants/styles/app_colors.dart';
import 'package:payment_feature/core/constants/styles/app_text_styles.dart';
import 'package:payment_feature/features/cart_checkout/data/models/order_summary_item.dart';

class TransactionSuccessfulView extends StatelessWidget {
  const TransactionSuccessfulView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
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
                    value: '01/24/2023',
                  ),
                ),
                const SizedBox(height: 20),
                OrderInfoItem(
                  orderSummaryItem: OrderSummaryItem(
                    label: 'Time',
                    value: '10:15 AM',
                  ),
                ),
                const SizedBox(height: 20),
                OrderInfoItem(
                  orderSummaryItem: OrderSummaryItem(
                    label: 'To',
                    value: 'Sam Louis',
                  ),
                ),
                Divider(height: 54, thickness: 1.5, indent: 15, endIndent: 15),
                OrderInfoItem(
                  orderSummaryItem: OrderSummaryItem(
                    label: 'Total',
                    value: '\$50.97',
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
                          child: Image.asset(AppAssets.imagesPaypal),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Completed by PayPal',
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
