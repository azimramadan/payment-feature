import 'package:flutter/material.dart';
import 'package:payment_feature/core/constants/app_assets.dart';
import 'package:payment_feature/features/cart_checkout/data/models/cart_item_model.dart';
import 'package:payment_feature/features/cart_checkout/data/models/order_summary_model.dart';
import 'package:payment_feature/features/cart_checkout/data/models/product_model.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/basket_area.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/payment_Summary_section.dart';

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
              child: BasketArea(
                ///////////////////////////////////////////////////////////////////////
                cartItems: List.generate(9, (index) {
                  return CartItemModel(
                    product: ProductModel(
                      availableQuantity: 10,
                      id: '1',
                      name: 'Product 1',
                      price: 10.99,
                      imagePath: AppAssets.imagesProduct1,
                    ),
                    quantity: 2,
                  );
                }),
              ),
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
