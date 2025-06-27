import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:payment_feature/features/cart_checkout/data/models/payment_intent_input_model.dart';
import 'package:payment_feature/features/cart_checkout/data/models/transaction_summary_model.dart';
import 'package:payment_feature/features/cart_checkout/data/repos/checkout_repo.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/payment_method_selector.dart';

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

    var transactionSummaryModel = TransactionSummaryModel(
      date: getTodayDate(),
      time: getCurrentTime12Hour(),
      paymentMethod: PaymentMethod.card.toString(),
      recipientName: 'Abdelazim Ramadan',
      totalAmount: paymentIntentInputModel.amount.toStringAsFixed(2),
    );
    result.fold(
      (failure) => emit(CheckoutFailure(message: failure.message)),
      (success) => emit(
        CheckoutSuccess(transactionSummaryModel: transactionSummaryModel),
      ),
    );
  }

  String getCurrentTime12Hour() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('hh:mm:ss a');
    return formatter.format(now);
  }

  String getTodayDate() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }
}
