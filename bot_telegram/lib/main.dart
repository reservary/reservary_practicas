import 'package:bot_telegram/bot/telegram_bot_mensaje.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Bot Telegram Demo', home: TelegramBotMensaje());
  }
}
