part of 'product_cubit_cubit.dart';

@immutable
sealed class ProductCubitState {}

final class ProductCubitInitial extends ProductCubitState {}

class ProductCubitUpdated extends ProductCubitState {
  final List<CartItemModel> cartItems;

  ProductCubitUpdated({required this.cartItems});
}

class ProductCubitError extends ProductCubitState {
  final String message;

  ProductCubitError({required this.message});
}
