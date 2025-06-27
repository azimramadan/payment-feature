class PaymentIntentInputModel {
  final double amount;
  final String currency;
  final String customer;
  PaymentIntentInputModel({
    required this.customer,
    required this.amount,
    this.currency = 'usd',
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': (amount * 100).toInt(),
      'currency': currency,
      "payment_method_types[]": "card",
      'customer': customer,
    };
  }
}
