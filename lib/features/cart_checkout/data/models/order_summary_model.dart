class OrderSummaryModel {
  final double orderSubtotal;
  final double discount;
  final double shipping;
  final double total;

  const OrderSummaryModel({
    required this.orderSubtotal,
    required this.discount,
    required this.shipping,
  }) : total = orderSubtotal - discount + shipping;
}
