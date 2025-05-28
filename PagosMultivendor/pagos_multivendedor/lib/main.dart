import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> _crearSesionDePago() async {
    final respuesta = await http.post(
      Uri.parse('https://<TU_BACKEND>.replit.app/create-checkout-session'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'priceId': 'price_1234'}), // el ID del precio que configures en Stripe
    );

    if (respuesta.statusCode == 200) {
      final data = jsonDecode(respuesta.body);
      final checkoutUrl = data['url'];
      if (await canLaunchUrl(Uri.parse(checkoutUrl))) {
        await launchUrl(Uri.parse(checkoutUrl), mode: LaunchMode.externalApplication);
      } else {
        throw 'No se pudo abrir el navegador';
      }
    } else {
      throw 'Error al crear sesión: ${respuesta.body}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Pagos con Stripe')),
        body: Center(
          child: ElevatedButton(
            onPressed: _crearSesionDePago,
            child: Text('Pagar con Stripe'),
          ),
        ),
      ),
    );
  }
}
