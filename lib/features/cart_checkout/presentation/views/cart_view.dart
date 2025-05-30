import 'package:flutter/material.dart';
import 'package:payment_feature/core/constants/styles/app_text_styles.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/cart_view_body.dart';

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
