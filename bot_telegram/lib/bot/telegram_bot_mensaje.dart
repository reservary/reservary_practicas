import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatMessage {
  final String sender;
  final String text;
  final DateTime time;

  ChatMessage({required this.sender, required this.text, required this.time});
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> sentMessages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final String botToken =
      '8050410418:AAHwTQ408LCGlWEO5zmuDtV4jASU6mjxBRA'; //Te lo da el botfather
  final String chatId =
      '-1002579298196'; //Se puede obtener desde https://api.telegram.org/bot<TOKEN>/getUpdates

  int lastUpdateId = 0;

  @override
  void initState() {
    super.initState();
    startPolling();
  }

  void startPolling() {
    Timer.periodic(const Duration(seconds: 3), (_) {
      fetchMessagesFromBot();
    });
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> fetchMessagesFromBot() async {
    final url =
        'https://api.telegram.org/bot$botToken/getUpdates?offset=${lastUpdateId + 1}';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List updates = data['result'];

        for (var update in updates) {
          lastUpdateId = update['update_id'];

          final message = update['message'];
          if (message != null &&
              message['chat'] != null &&
              message['chat']['id'].toString() == chatId &&
              message['text'] != null) {
            final text = message['text'];
            final sender = message['from']?['first_name'] ?? 'Desconocido';
            final int timestamp = message['date'];
            final DateTime time = DateTime.fromMillisecondsSinceEpoch(
              timestamp * 1000,
            );

            final newMessage = ChatMessage(
              sender: sender,
              text: text,
              time: time,
            );

            if (!sentMessages.any(
              (msg) =>
                  msg.text == newMessage.text &&
                  msg.sender == newMessage.sender &&
                  msg.time == newMessage.time,
            )) {
              setState(() {
                sentMessages.add(newMessage);
              });
              scrollToBottom();
            }
          }
        }
      } else {
        print('Error en getUpdates: ${response.body}');
      }
    } catch (e) {
      print('Error de red: $e');
    }
  }

  Future<void> sendMessageToTelegram(String message) async {
    final String url =
        'https://api.telegram.org/bot$botToken/sendMessage?chat_id=$chatId&text=${Uri.encodeFull(message)}';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        print('Mensaje enviado');
        setState(() {
          sentMessages.add(
            ChatMessage(sender: 'Tú', text: message, time: DateTime.now()),
          );
        });
        scrollToBottom();
      } else {
        print('Error al enviar mensaje: ${response.body}');
      }
    } catch (e) {
      print('Error de red: $e');
    }
  }

  void handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    sendMessageToTelegram(text);
    _controller.clear();
  }

  Widget buildMessage(ChatMessage msg) {
    final bool isOwnMessage = msg.sender == 'Tú';
    final timeFormatted =
        '${msg.time.hour.toString().padLeft(2, '0')}:${msg.time.minute.toString().padLeft(2, '0')}';

    return Align(
      alignment: isOwnMessage ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isOwnMessage ? Colors.grey[300] : Colors.lightBlue[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment:
              isOwnMessage ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Text(
              msg.sender,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(msg.text),
            const SizedBox(height: 4),
            Text(
              timeFormatted,
              style: const TextStyle(fontSize: 10, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat de Grupo')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: sentMessages.length,
              itemBuilder: (context, index) {
                return buildMessage(sentMessages[index]);
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Escribe un mensaje...',
                    ),
                    onSubmitted: (_) => handleSend(),
                  ),
                ),
                IconButton(icon: const Icon(Icons.send), onPressed: handleSend),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
