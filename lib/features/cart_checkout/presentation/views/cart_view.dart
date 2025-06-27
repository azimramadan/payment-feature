import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_feature/core/constants/styles/app_text_styles.dart';
import 'package:payment_feature/core/services/api_service.dart';
import 'package:payment_feature/core/services/stripe_service.dart';
import 'package:payment_feature/features/cart_checkout/data/repos/checkout_repo_impl.dart';
import 'package:payment_feature/features/cart_checkout/presentation/view_models/checkout_cubit/checkout_cubit.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/cart_view_body.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutCubit(
        CheckoutRepoImpl(
          stripeService: StripeService(apiService: ApiService(dio: Dio())),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Cart', style: AppTextStyles.interMedium25(context)),
          centerTitle: true,
        ),
        body: CustomScrollView(
          slivers: [SliverFillRemaining(child: CartViewBody())],
        ),
      ),
    );
  }
}
