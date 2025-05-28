import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> crearCuentaYOnboarding() async {
    final res = await http.post(
      Uri.parse('https://TU_BACKEND/create-account'),
    );
    final data = jsonDecode(res.body);
    final onboardingUrl = data['url'];
    await launchUrl(Uri.parse(onboardingUrl), mode: LaunchMode.externalApplication);
  }

  Future<void> pagar(String accountId) async {
    final res = await http.post(
      Uri.parse('https://TU_BACKEND/create-payment-intent'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'amount': 5000, 'connectedAccountId': accountId}),
    );

    final data = jsonDecode(res.body);
    final clientSecret = data['clientSecret'];

    await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: clientSecret,
      merchantDisplayName: 'Fitcron',
    ));

    await Stripe.instance.presentPaymentSheet();
  }

  @override
  Widget build(BuildContext context) {
    const cuentaEjemplo = 'acct_123abc456def'; // reemplazar por ID real
    return Scaffold(
      appBar: AppBar(title: const Text('Fitcron Pagos')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: crearCuentaYOnboarding,
              child: const Text('Crear cuenta Stripe (entrenador)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => pagar(cuentaEjemplo),
              child: const Text('Pagar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}