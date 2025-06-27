import 'package:flutter/material.dart';
import 'package:payment_feature/core/constants/styles/app_colors.dart';
import 'package:payment_feature/core/constants/styles/app_text_styles.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/cart_view.dart';

class ProductViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProductViewAppBar({
    super.key,
    required this.screenWidth,
    required this.title,
  });

  final double screenWidth;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(title, style: AppTextStyles.interMedium25(context)),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: screenWidth * 0.02),
          child: IconButton(
            iconSize: screenWidth * 0.060,
            color: AppColors.black,
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => CartView()));
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
