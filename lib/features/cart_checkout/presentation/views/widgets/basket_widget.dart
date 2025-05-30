import 'package:flutter/material.dart';
import 'package:payment_feature/core/constants/app_assets.dart';

class BasketWidget extends StatelessWidget {
  const BasketWidget({super.key, required this.widgets});

  final List<Widget> widgets;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.imagesBasket),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(clipBehavior: Clip.none, children: widgets),
    );
  }
}
