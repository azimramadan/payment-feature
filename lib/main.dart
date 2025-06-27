import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_feature/core/constants/styles/app_colors.dart';
import 'package:payment_feature/core/constants/styles/app_text_styles.dart';
import 'package:payment_feature/features/cart_checkout/presentation/view_models/product_cubit/product_cubit_cubit.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/product_card_grid_view.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/action_button.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Stripe.publishableKey = dotenv.env['PUBLISHABLE_kEY'] ?? '';

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
