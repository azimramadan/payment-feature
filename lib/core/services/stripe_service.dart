import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_feature/core/services/api_service.dart';
import 'package:payment_feature/core/shared/data/models/user_model.dart';
import 'package:payment_feature/features/cart_checkout/data/models/customer/customer.dart';
import 'package:payment_feature/features/cart_checkout/data/models/ephemeral_key_model/ephemeral_key_model.dart';
import 'package:payment_feature/features/cart_checkout/data/models/init_payment_sheet_input_model.dart';
import 'package:payment_feature/features/cart_checkout/data/models/payment_intent_input_model.dart';
import 'package:payment_feature/features/cart_checkout/data/models/payment_intent_model/payment_intent_model.dart';

class StripeService {
  final ApiService _apiService;
  static const String _baseUrl = 'https://api.stripe.com/v1';
  static const String _stripePaymentIntentUrl = '$_baseUrl/payment_intents';
  static const String _stripeCreateCustomerUrl = '$_baseUrl/customers';
  static const String _stripeCreateEphemeralKeyUrl = '$_baseUrl/ephemeral_keys';
  static const String _merchantName = 'Abdelazim Ramadan';

  const StripeService({required ApiService apiService})
    : _apiService = apiService;

  /// This function is not tested yet.
  Future<Customer> createCustomer({required UserModel userModel}) async {
    final secretKey = dotenv.env['SECRET_kEY'];
    if (secretKey == null || secretKey.isEmpty) {
      throw Exception('Stripe secret key is not set in .env');
    }
    final response = await _apiService.post(
      body: userModel.toJson(),
      url: _stripeCreateCustomerUrl,
      token: secretKey,
    );
    return Customer.fromJson(response.data);
  }

  Future<EphemeralKeyModel> createEphemeralKeys({
    required String customerId,
  }) async {
    final secretKey = dotenv.env['SECRET_kEY'];
    if (secretKey == null || secretKey.isEmpty) {
      throw Exception('Stripe secret key is not set in .env');
    }
    final response = await _apiService.post(
      body: {'customer': customerId},
      url: _stripeCreateEphemeralKeyUrl,
      token: secretKey,
      headers: {
        'Stripe-Version': '2025-05-28.basil',
        'Authorization': 'Bearer $secretKey',
      },
    );
    return EphemeralKeyModel.fromJson(response.data);
  }

  Future<PaymentIntentModel> createPaymentIntent({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    final secretKey = dotenv.env['SECRET_kEY'];
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
    required InitPaymentSheetInputModel paymentSheetParameters,
  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        merchantDisplayName: _merchantName,
        paymentIntentClientSecret:
            paymentSheetParameters.paymentIntentClientSecret,
        customerId: paymentSheetParameters.customerId,
        customerEphemeralKeySecret:
            paymentSheetParameters.customerEphemeralKeySecret,
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
    var ephemeralKey = await createEphemeralKeys(
      customerId: paymentIntentInputModel.customer,
    );
    final clientSecret = paymentIntent.clientSecret;

    if (clientSecret == null ||
        clientSecret.isEmpty ||
        ephemeralKey.secret == null) {
      throw Exception('Invalid client secret received from Stripe.');
    }
    InitPaymentSheetInputModel initPaymentSheetInputModel =
        InitPaymentSheetInputModel(
          paymentIntentClientSecret: clientSecret,
          customerId: paymentIntentInputModel.customer,
          customerEphemeralKeySecret: ephemeralKey.secret!,
        );
    await initPaymentSheet(paymentSheetParameters: initPaymentSheetInputModel);
    await presentPaymentSheet();
  }
}
