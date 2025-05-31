import 'package:flutter/material.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/product_card_grid_view_body.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/product_view_app_bar.dart';

class ProductCardGridView extends StatelessWidget {
  const ProductCardGridView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProductViewAppBar(
        screenWidth: MediaQuery.of(context).size.width,
        title: 'Products',
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16, top: 8),
        child: ProductCardGridViewBody(),
      ),
    );
  }
}
