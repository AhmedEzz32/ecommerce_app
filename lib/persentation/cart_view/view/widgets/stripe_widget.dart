
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeWidget extends StatelessWidget {

  const StripeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CardField();
    return SizedBox(
      height: 80,
      width: 300,
      child: PlatformPayButton(
        onPressed: () {
          final route = MaterialPageRoute(builder: (_) => const ExpressCheckoutElementExample());
          Navigator.push(context, route);
        },
        type: PlatformButtonType.buy,
        // constraints: const BoxConstraints.expand(height: 48),
      ),
    );
  }
}

class ExpressCheckoutElementExample extends StatefulWidget {
  const ExpressCheckoutElementExample({super.key});

  @override
  ThemeCardExampleState createState() => ThemeCardExampleState();
}

class ThemeCardExampleState extends State<ExpressCheckoutElementExample> {
  String? clientSecret;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getClientSecret();
    });
  }

  Future<void> getClientSecret() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final client = await createPaymentIntent();
      setState(() {
        clientSecret = client;
      });
    } catch (e) {
      if (mounted) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 52),
          child: Column(
            children: [
              SizedBox(
                  child: clientSecret != null
                      ? ExpressCheckoutWidget(clientSecret!)
                      : const Center(child: CircularProgressIndicator())),
              // LoadingButton(onPressed: pay, text: 'Pay'),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> createPaymentIntent() async {
    return 'clientSecret';
    // final url = Uri.parse('$kApiUrl/create-payment-intent');
    // final response = await http.post(
    //   url,
    //   headers: {
    //     'Content-Type': 'application/json',
    //   },
    //   body: json.encode({
    //     'currency': 'usd',
    //     'amount': 5099,
    //   }),
    // );
    // return json.decode(response.body)['clientSecret'];
  }
}


class ExpressCheckoutWidget extends StatelessWidget {
  const ExpressCheckoutWidget(this.clientSecret, {super.key});

  final String? clientSecret;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}