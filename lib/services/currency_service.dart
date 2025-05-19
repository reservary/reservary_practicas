import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  static const String _baseUrl = 'https://api.exchangerate-api.com/v4/latest/EUR';

  Future<double> convertFromEUR(String toCurrency, double amount) async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['rates'] != null) {
          final rates = data['rates'] as Map<String, dynamic>;
          final rate = rates[toCurrency];
          if (rate != null) {
            // Aseguramos que el monto y la tasa sean números
            final amountNum = amount.toDouble();
            final rateNum = rate.toDouble();
            return amountNum * rateNum;
          } else {
            throw Exception('No se encontró la tasa de cambio para $toCurrency');
          }
        } else {
          throw Exception('Error en la respuesta de la API de divisas');
        }
      } else {
        throw Exception('Error al conectar con la API de divisas');
      }
    } catch (e) {
      throw Exception('Error al convertir la moneda: $e');
    }
  }

  // Mapa de países a sus códigos de moneda
  static const Map<String, String> countryToCurrency = {
    'US': 'USD', // Estados Unidos
    'GB': 'GBP', // Reino Unido
    'EU': 'EUR', // Unión Europea
    'JP': 'JPY', // Japón
    'KR': 'KRW', // Corea del Sur
    'CN': 'CNY', // China
    'IN': 'INR', // India
    'BR': 'BRL', // Brasil
    'MX': 'MXN', // México
    'AR': 'ARS', // Argentina
    'CL': 'CLP', // Chile
    'CO': 'COP', // Colombia
    'PE': 'PEN', // Perú
    'VE': 'VES', // Venezuela
    'UY': 'UYU', // Uruguay
    'PY': 'PYG', // Paraguay
    'BO': 'BOB', // Bolivia
    'EC': 'USD', // Ecuador
    'CR': 'CRC', // Costa Rica
    'PA': 'PAB', // Panamá
    'DO': 'DOP', // República Dominicana
    'GT': 'GTQ', // Guatemala
    'SV': 'SVC', // El Salvador
    'HN': 'HNL', // Honduras
    'NI': 'NIO', // Nicaragua
    'CA': 'CAD', // Canadá
    'AU': 'AUD', // Australia
    'NZ': 'NZD', // Nueva Zelanda
    'CH': 'CHF', // Suiza
    'SE': 'SEK', // Suecia
    'NO': 'NOK', // Noruega
    'DK': 'DKK', // Dinamarca
    'PL': 'PLN', // Polonia
    'CZ': 'CZK', // República Checa
    'HU': 'HUF', // Hungría
    'RO': 'RON', // Rumania
    'BG': 'BGN', // Bulgaria
    'HR': 'HRK', // Croacia
    'RS': 'RSD', // Serbia
    'UA': 'UAH', // Ucrania
    'RU': 'RUB', // Rusia
    'TR': 'TRY', // Turquía
    'IL': 'ILS', // Israel
    'AE': 'AED', // Emiratos Árabes Unidos
    'SA': 'SAR', // Arabia Saudita
    'ZA': 'ZAR', // Sudáfrica
    'EG': 'EGP', // Egipto
    'NG': 'NGN', // Nigeria
    'KE': 'KES', // Kenia
    'SG': 'SGD', // Singapur
    'MY': 'MYR', // Malasia
    'ID': 'IDR', // Indonesia
    'TH': 'THB', // Tailandia
    'VN': 'VND', // Vietnam
    'PH': 'PHP', // Filipinas
  };

  String getCurrencyCode(String countryCode) {
    return countryToCurrency[countryCode] ?? 'EUR';
  }
} 