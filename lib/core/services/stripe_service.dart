
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mini_app/core/constants.dart';
import 'package:mini_app/core/services/_service_interface.dart';

class StripeService extends ServiceInterface {

  final Constants _constants;

  StripeService(this._constants);

  @override
  Future<void> init() async {
    Stripe.publishableKey = _constants.stripe_publishable_key;
    print("StripeService initialized successfully!");
  }

  @override
  Future<void> dispose() async {
    print("StripeService disposed successfully!");
  }
}