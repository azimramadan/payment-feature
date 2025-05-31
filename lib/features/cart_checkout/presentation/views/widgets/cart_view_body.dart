import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_feature/core/constants/app_assets.dart';
import 'package:payment_feature/features/cart_checkout/data/models/cart_item_model.dart';
import 'package:payment_feature/features/cart_checkout/data/models/product_model.dart';
import 'package:payment_feature/features/cart_checkout/presentation/view_models/cubit/product_cubit_cubit.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/basket_area.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/payment_Summary_section.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: BlocBuilder<ProductCubitCubit, ProductCubitState>(
        builder: (context, state) {
          List<CartItemModel> cartItems = BlocProvider.of<ProductCubitCubit>(
            context,
          ).cardItemList;
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 37.0,
                    vertical: 10,
                  ),
                  child: BasketArea(
                    cartItems: List.generate(cartItems.length, (index) {
                      return cartItems[index];
                    }),
                  ),
                ),
              ),

              const SizedBox(height: 15),
              PaymentSummarySection(
                orderSummaryModel: BlocProvider.of<ProductCubitCubit>(
                  context,
                ).summary,
              ),
            ],
          );
        },
      ),
    );
  }
}
