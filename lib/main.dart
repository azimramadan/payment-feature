import 'package:flutter/material.dart';
import 'package:payment_feature/core/constants/app_assets.dart';
import 'package:payment_feature/core/constants/styles/app_colors.dart';
import 'package:payment_feature/core/constants/styles/app_text_styles.dart';
import 'package:payment_feature/features/cart_checkout/data/models/order_summary_item.dart';
import 'package:payment_feature/features/cart_checkout/data/models/order_summary_model.dart';
// import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const CartCheckout());
}

class CartCheckout extends StatelessWidget {
  const CartCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const CartView());
  }
}

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart', style: AppTextStyles.interMedium25(context)),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [SliverFillRemaining(child: CartViewBody())],
      ),
    );
  }
}

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 37.0,
                vertical: 10,
              ),
              child: FixedPositionsGrid(),
            ),
          ),

          const SizedBox(height: 15),
          PaymentSummarySection(
            orderSummaryModel: OrderSummaryModel(
              orderSubtotal: 42.97,
              discount: 0.0,
              shipping: 8.0,
            ),
          ),
        ],
      ),
    );
  }
}

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
            value: '\$&${orderSummaryModel.orderSubtotal.toStringAsFixed(2)}',
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

class ActionButton extends StatelessWidget {
  const ActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.green,
        minimumSize: const Size(double.infinity, 65),
        maximumSize: const Size(double.infinity, 65),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Text(
        'Complete Payment',
        style: AppTextStyles.interMedium22(context),
      ),
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

class FixedPositionsGrid extends StatelessWidget {
  final List<String> imagePaths = [
    AppAssets.imagesProduct1,
    AppAssets.imagesProduct2,
    AppAssets.imagesProduct3,
    AppAssets.imagesProduct4,
    AppAssets.imagesProduct5,
    AppAssets.imagesProduct6,
    AppAssets.imagesProduct7,
    AppAssets.imagesProduct8,
    AppAssets.imagesProduct9,
  ];

  FixedPositionsGrid({super.key});

  final Map<int, List<Offset>> fixedPositions = {
    1: [Offset(0.5, 0.5)],
    2: [Offset(0.4, 0.37), Offset(0.6, 0.65)],
    3: [Offset(0.5, 0.3), Offset(0.35, 0.55), Offset(0.65, 0.65)],
    4: [
      Offset(0.35, 0.35),
      Offset(0.65, 0.35),
      Offset(0.35, 0.65),
      Offset(0.65, 0.65),
    ],
    5: [
      Offset(0.5, 0.32),
      Offset(0.3, 0.5),
      Offset(0.7, 0.5),
      Offset(0.35, 0.75),
      Offset(0.65, 0.75),
    ],
    6: [
      Offset(0.4, 0.3),
      Offset(0.6, 0.3),
      Offset(0.4, 0.5),
      Offset(0.6, 0.5),
      Offset(0.4, 0.7),
      Offset(0.6, 0.7),
    ],
    7: [
      Offset(0.3, 0.3),
      Offset(0.5, 0.3),
      Offset(0.7, 0.3),
      Offset(0.3, 0.5),
      Offset(0.5, 0.5),
      Offset(0.7, 0.5),
      Offset(0.5, 0.7),
    ],
    8: [
      Offset(0.3, 0.3),
      Offset(0.5, 0.3),
      Offset(0.7, 0.3),
      Offset(0.3, 0.5),
      Offset(0.5, 0.5),
      Offset(0.7, 0.5),
      Offset(0.4, 0.7),
      Offset(0.6, 0.7),
    ],
    9: [
      Offset(0.3, 0.3),
      Offset(0.5, 0.3),
      Offset(0.7, 0.3),
      Offset(0.3, 0.5),
      Offset(0.5, 0.5),
      Offset(0.7, 0.5),
      Offset(0.3, 0.7),
      Offset(0.5, 0.7),
      Offset(0.7, 0.7),
    ],
  };

  @override
  Widget build(BuildContext context) {
    int count = imagePaths.length.clamp(1, 10);
    final positions = fixedPositions[count]!;

    double baseSize = 150;
    double minSize = 70;
    double imageSize = (baseSize - (count - 1) * 12).clamp(minSize, baseSize);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        List<Widget> widgets = List.generate(count, (index) {
          final pos = positions[index];
          final left = (pos.dx * width) - imageSize / 2;
          final top = (pos.dy * height) - imageSize / 2;

          return Positioned(
            left: left,
            top: top,
            child: GestureDetector(
              onTap: () {},
              child: Image.asset(
                imagePaths[index],
                width: imageSize,
                height: imageSize,
                fit: BoxFit.cover,
              ),
            ),
          );
        });

        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.imagesBasket),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(clipBehavior: Clip.none, children: widgets),
        );
      },
    );
  }
}
