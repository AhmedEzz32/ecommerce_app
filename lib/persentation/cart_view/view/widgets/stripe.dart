
import 'package:flutter/material.dart';
import 'package:mini_app/core/di/service_locators.dart';
import 'package:mini_app/core/services/stripe_service_widget.dart';
import 'package:mini_app/generated/l10n.dart';

class StripeWidget extends StatelessWidget {

  final double amount;
  final String currency;

  const StripeWidget({
    super.key,
    required this.amount,
    this.currency = 'USD',
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.payment),
      label: Text(S.current.pay_with_stripe),
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(double.infinity, 50),
      ),
      onPressed: () {
        getIt<StripeService>().pay(
          amount: amount,
          currency: currency,
        );
      },
    );
    /* ListTile(
      title: const Text('Pay with Stripe'),
      onTap: () {
        getIt<StripeService>().pay(
          amount: amount,
          currency: currency,
        );
      },
    ); */
  }
}