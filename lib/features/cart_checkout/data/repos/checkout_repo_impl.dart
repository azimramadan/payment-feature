import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_feature/core/errors/failures.dart';
import 'package:payment_feature/core/services/stripe_service.dart';
import 'package:payment_feature/features/cart_checkout/data/models/payment_intent_input_model.dart';
import 'package:payment_feature/features/cart_checkout/data/repos/checkout_repo.dart';

class CheckoutRepoImpl implements CheckoutRepo {
  final StripeService _stripeService;

  CheckoutRepoImpl({required StripeService stripeService})
    : _stripeService = stripeService;

  @override
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    try {
      await _stripeService.makePayment(
        paymentIntentInputModel: paymentIntentInputModel,
      );
      return const Right(null);
    } on DioException catch (dioError) {
      return Left(ServerFailure.fromDioException(dioError));
    } on StripeException catch (stripeError) {
      return Left(
        ServerFailure(
          'Stripe error: ${stripeError.error.localizedMessage ?? 'Unknown Stripe error.'}',
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
