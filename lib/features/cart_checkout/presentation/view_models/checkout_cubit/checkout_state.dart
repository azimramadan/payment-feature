part of 'checkout_cubit.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutSuccess extends CheckoutState {
  final TransactionSummaryModel transactionSummaryModel;

  CheckoutSuccess({required this.transactionSummaryModel});
}

class CheckoutFailure extends CheckoutState {
  final String message;

  CheckoutFailure({required this.message});
}
