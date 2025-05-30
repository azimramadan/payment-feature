import 'package:flutter/material.dart';
import 'package:payment_feature/core/constants/app_assets.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/cart_view.dart';
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
