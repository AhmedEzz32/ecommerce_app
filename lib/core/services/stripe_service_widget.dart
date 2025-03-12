import 'package:dio/dio.dart';
import 'package:flutter/material.dart' show ThemeMode, debugPrint;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mini_app/core/constants.dart';
import 'package:mini_app/core/services/_service_interface_widget.dart';

class StripeService extends ServiceInterface {

  final Constants _constants;

  StripeService(this._constants);

  @override
  Future<void> init() async {
    Stripe.publishableKey = _constants.stripe_publishable_key;
    await Stripe.instance.applySettings();
    debugPrint("StripeService initialized successfully!");
  }

  @override
  Future<void> dispose() async {
    debugPrint("StripeService disposed successfully!");
  }

  Future<bool> pay({
    required double amount,
    required String currency,
  }) async {
    try {
      final paymentIntent = await _createPaymentIntent(
        amount: _convertAmount(amount),
        currency: currency,
      );
      
      if (paymentIntent == null) {
        debugPrint('Error creating payment intent');
        return false;
      }
      
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent,
          style: ThemeMode.light,
          merchantDisplayName: 'Mini App',
        ),
      );
      
      await Stripe.instance.presentPaymentSheet();
      
      debugPrint('Payment Successful');
      return true;
    } catch (e) {
      debugPrint('Error paying: $e');
      return false;
    }
  }

  Future<String?> _createPaymentIntent({
    required int amount,
    required String currency,
  }) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        'amount': amount,
        'currency': currency,
      };
      //"This exception was thrown because the response has a status code of 403 and RequestOptions.validateStatus was configured to thro…"

      var response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${_constants.stripe_secret_key}',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );
      
      if (response.statusCode == 200) {
        return response.data['client_secret'];
      } else {
        throw Exception('Failed to create payment intent');
      }
    } catch (e) {
      debugPrint('Error creating payment intent: $e');
      return null;
    }
  }
  
  int _convertAmount(double amount) {
    /// convert double amount to integer but if decimal part > 0.5 then round up
    return (amount * 100).ceil();
  }
}