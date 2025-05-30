import 'package:flutter/material.dart';
import 'package:payment_feature/features/cart_checkout/data/models/cart_item_model.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/basket_with_items.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/empty_basket.dart';

class BasketArea extends StatelessWidget {
  const BasketArea({super.key, required this.cartItems});
  final List<CartItemModel> cartItems;
  @override
  Widget build(BuildContext context) {
    if (cartItems.isEmpty) {
      return EmptyBasket();
    }
    return BasketWithItems(cartItems: cartItems);
  }
}
