import 'package:http/http.dart' as http;

final String botToken = '8050410418:AAHwTQ408LCGlWEO5zmuDtV4jASU6mjxBRA';
final String chatId = '-1002579298196';

Future<void> mensajeTelegram(String message) async {
  final url = Uri.parse('https://api.telegram.org/bot$botToken/sendMessage');

  final response = await http.post(
    url,
    body: {'chat_id': chatId, 'text': message},
  );

  if (response.statusCode == 200) {
    print('Mensaje enviado con éxito');
  } else {
    print('Error al enviar el mensaje: ${response.body}');
  }
}
