import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_feature/features/cart_checkout/presentation/view_models/cubit/product_cubit_cubit.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/product_card_grid_view.dart';

void main() {
  runApp(const CartCheckout());
}

class CartCheckout extends StatelessWidget {
  const CartCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubitCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const ProductCardGridView(),
      ),
    );
  }
}
