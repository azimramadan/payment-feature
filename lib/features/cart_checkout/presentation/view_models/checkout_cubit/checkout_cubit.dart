import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:payment_feature/features/cart_checkout/data/models/payment_intent_input_model.dart';
import 'package:payment_feature/features/cart_checkout/data/repos/checkout_repo.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final CheckoutRepo checkoutRepo;

  CheckoutCubit(this.checkoutRepo) : super(CheckoutInitial());

  Future<void> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    emit(CheckoutLoading());
    final result = await checkoutRepo.makePayment(
      paymentIntentInputModel: paymentIntentInputModel,
    );

    result.fold(
      (failure) => emit(CheckoutFailure(message: failure.message)),
      (success) => emit(CheckoutSuccess()),
    );
  }
}
