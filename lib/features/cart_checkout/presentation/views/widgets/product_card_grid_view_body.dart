import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_feature/features/cart_checkout/data/models/product_model.dart';
import 'package:payment_feature/features/cart_checkout/presentation/view_models/product_cubit/product_cubit_cubit.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/product_card.dart';

class ProductCardGridViewBody extends StatefulWidget {
  const ProductCardGridViewBody({super.key});

  @override
  State<ProductCardGridViewBody> createState() =>
      _ProductCardGridViewBodyState();
}

class _ProductCardGridViewBodyState extends State<ProductCardGridViewBody> {
  List<ProductModel> productList = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productList = BlocProvider.of<ProductCubitCubit>(context).productList;
    return BlocBuilder<ProductCubitCubit, ProductCubitState>(
      builder: (context, state) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.55,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: productList.length,
          itemBuilder: (context, index) {
            return ProductCard(productModel: productList[index]);
          },
        );
      },
    );
  }
}
