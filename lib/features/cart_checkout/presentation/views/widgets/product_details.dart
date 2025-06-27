import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_feature/core/constants/styles/app_colors.dart';
import 'package:payment_feature/core/constants/styles/app_text_styles.dart';
import 'package:payment_feature/features/cart_checkout/data/models/product_model.dart';
import 'package:payment_feature/features/cart_checkout/presentation/view_models/product_cubit/product_cubit_cubit.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/product_details_content.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        color: AppColors.green,
      ),
      padding: EdgeInsets.all(8),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductDetailsContent(productModel: productModel),
          Spacer(),
          AddToCartButton(productModel: productModel),
        ],
      ),
    );
  }
}

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    bool isInCart = BlocProvider.of<ProductCubitCubit>(
      context,
    ).inTheBasket(productModel);
    int cartCount = BlocProvider.of<ProductCubitCubit>(
      context,
    ).cartItemList.length;
    return BlocConsumer<ProductCubitCubit, ProductCubitState>(
      listener: (context, state) {
        if (state is ProductCubitError) {
          isInCart = false;
          showMassage(context, state.message);
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: Colors.white,
            maximumSize: Size(double.infinity, 45),
            minimumSize: Size(double.infinity, 45),
          ),
          onPressed: () {
            if (isInCart) {
              BlocProvider.of<ProductCubitCubit>(
                context,
              ).removeFromCart(productModel);

              showMassage(
                context,
                '${productModel.name} has been removed from your cart.',
              );
              return;
            } else if (cartCount >= 9) {
              showMassage(
                context,
                'You can only add up to 9 items to the cart.',
                color: AppColors.red,
              );
            } else {
              BlocProvider.of<ProductCubitCubit>(
                context,
              ).addToCart(productModel);
              showMassage(
                context,
                '${productModel.name} has been added to your cart.',
              );
            }
          },
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              isInCart ? 'Remove from Cart' : 'Add to Cart',
              style: isInCart
                  ? AppTextStyles.interRegular20(
                      context,
                    ).copyWith(color: AppColors.red)
                  : AppTextStyles.interRegular20(context),
            ),
          ),
        );
      },
    );
  }

  void showMassage(BuildContext context, String message, {Color? color}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color ?? AppColors.gray,
        content: Text(
          message,
          style: AppTextStyles.interRegular20(
            context,
          ).copyWith(color: AppColors.white),
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
