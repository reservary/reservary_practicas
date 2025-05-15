import 'package:bot_telegram/bot/telegram_bot_llamada.dart';
import 'package:flutter/material.dart';

class TelegramBotMensaje extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bot Telegram Demo')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            mensajeTelegram('¡Hola desde Flutter!');
          },
          child: Text('Enviar mensaje al grupo'),
        ),
      ),
    );
  }
}
