import 'package:flutter/material.dart';
import 'package:payment_feature/features/cart_checkout/data/models/product_model.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/product_details.dart';

class ProductCard extends StatelessWidget {
  final ProductModel productModel;

  const ProductCard({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color(0xffB8B8B8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImage(imageUrl: productModel.imagePath),
            Expanded(child: ProductDetails(productModel: productModel)),
          ],
        ),
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),

          child: Image.asset(imageUrl),
        ),
      ),
    );
  }
}
