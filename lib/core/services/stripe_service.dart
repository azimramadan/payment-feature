import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_feature/core/services/api_service.dart';
import 'package:payment_feature/features/cart_checkout/data/models/payment_intent_input_model.dart';
import 'package:payment_feature/features/cart_checkout/data/models/payment_intent_model/payment_intent_model.dart';

class StripeService {
  final ApiService _apiService;

  static const _stripePaymentIntentUrl =
      'https://api.stripe.com/v1/payment_intents';
  static const _merchantName = 'Abdelazim Ramadan';

  const StripeService({required ApiService apiService})
    : _apiService = apiService;

  Future<PaymentIntentModel> createPaymentIntent({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    final secretKey = dotenv.env['SECRET_KEY'];
    if (secretKey == null || secretKey.isEmpty) {
      throw Exception('Stripe secret key is not set in .env');
    }
    final response = await _apiService.post(
      body: paymentIntentInputModel.toJson(),
      url: _stripePaymentIntentUrl,
      token: secretKey,
    );
    return PaymentIntentModel.fromJson(response.data);
  }

  Future<void> initPaymentSheet({
    required String paymentIntentClientSecret,
  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        merchantDisplayName: _merchantName,
        paymentIntentClientSecret: paymentIntentClientSecret,
      ),
    );
  }

  Future<void> presentPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future<void> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    var paymentIntent = await createPaymentIntent(
      paymentIntentInputModel: paymentIntentInputModel,
    );
    final clientSecret = paymentIntent.clientSecret;

    if (clientSecret == null || clientSecret.isEmpty) {
      throw Exception('Invalid client secret received from Stripe.');
    }
    await initPaymentSheet(paymentIntentClientSecret: clientSecret);
    await presentPaymentSheet();
  }
}
