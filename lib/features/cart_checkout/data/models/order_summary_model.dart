import 'package:payment_feature/features/cart_checkout/data/models/cart_item_model.dart';

class OrderSummaryModel {
  final List<CartItemModel> cartItems;

  late final double subtotal;
  late final double shipping;
  late final double discount;
  late final double total;

  OrderSummaryModel({required this.cartItems}) {
    subtotal = _calculateSubtotal();
    shipping = _calculateShipping();
    discount = _calculateDiscount();
    total = subtotal + shipping - discount;
  }

  double _calculateSubtotal() {
    return cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  double _calculateShipping() {
    if (cartItems.isEmpty || _calculateSubtotal() == 0) return 0.0;
    return 20.0;
  }

  double _calculateDiscount() {
    final totalItems = cartItems.fold(0, (sum, item) => sum + item.quantity);
    if (totalItems >= 3) {
      return 10.0;
    }
    return 0.0;
  }
}
