import 'package:flutter/material.dart';
import 'package:payment_feature/core/constants/app_assets.dart';

class EmptyBasket extends StatelessWidget {
  const EmptyBasket({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.imagesBasket),
          fit: BoxFit.fill,
        ),
      ),
      child: SizedBox(),
    );
  }
}
