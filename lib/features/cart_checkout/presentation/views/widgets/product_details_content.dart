import 'package:flutter/material.dart';
import 'package:payment_feature/core/constants/styles/app_text_styles.dart';
import 'package:payment_feature/features/cart_checkout/data/models/product_model.dart';

class ProductDetailsContent extends StatelessWidget {
  const ProductDetailsContent({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Proudct Name: ${productModel.name}',
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: AppTextStyles.interRegular20(
            context,
          ).copyWith(color: Colors.white),
        ),
        SizedBox(height: 4),
        Text(
          'Price: \$${productModel.price.toStringAsFixed(2)}',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: AppTextStyles.interSemiBold20(
            context,
          ).copyWith(color: Colors.white70),
        ),
        SizedBox(height: 2),
        Text(
          'Avilable: ${productModel.availableQuantity}',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: AppTextStyles.interRegular18(context).copyWith(
            color: productModel.availableQuantity == 0
                ? Colors.red
                : Colors.white70,
          ),
        ),
      ],
    );
  }
}
