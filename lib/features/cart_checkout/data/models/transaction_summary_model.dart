import 'package:intl/intl.dart';
import 'package:payment_feature/core/constants/app_assets.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/payment_method_selector.dart';

class TransactionSummaryModel {
  final String date;
  final String time;
  final String recipientName;
  final String totalAmount;
  final String paymentMethod;

  get paymentMethodImage => paymentMethod == PaymentMethod.paypal.toString()
      ? AppAssets.imagesPaypal
      : AppAssets.imagesCredit;

  TransactionSummaryModel({
    String? date,
    String? time,
    required this.recipientName,
    required this.totalAmount,
    required this.paymentMethod,
  }) : date = date ?? _getTodayDate(),
       time = time ?? _getCurrentTime12Hour();

  static String _getCurrentTime12Hour() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('hh:mm:ss a');
    return formatter.format(now);
  }

  static String _getTodayDate() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }
}
