import 'dart:convert';
import 'package:http/http.dart' as http;

class DeepSeekLlamadas {
  final String apiKey = 'sk-b54158abc5b84d80a41933b58710aad2';
  final String baseUrl = 'https://api.deepseek.com/v1';

  Future<void> generarPlan(Map<dynamic, dynamic> datosUsuario) async {
    final url = Uri.parse('https://api.deepseek.com/v1/chat/completions');

    final prompt = '''
Eres un entrenador personal y nutricionita. A partir de los siguientes datos del usuario debes generar un plan semanal de entrenamiento y dieta detallada:
$datosUsuario
''';
    final body = jsonEncode({
      "model": "deepseek-chat",
      "messages": [
        {
          "role": "system",
          "content": "Eres un entrenador personal y nutricionaista.",
        },
        {"role": "user", "content": prompt},
      ],
    });
    final responseIA = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: body,
    );
    if (responseIA.statusCode == 200) {
      final respuestaIA = jsonDecode(responseIA.body);
      print(respuestaIA);
    } else {
      print('Error al generar el plan: ${responseIA.statusCode}');
    }
  }
}
