import 'package:dartz/dartz.dart';
import 'package:payment_feature/core/errors/failures.dart';
import 'package:payment_feature/features/cart_checkout/data/models/payment_intent_input_model.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  });
}
