import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ChatMessage {
  final String sender;
  final String message;
  final String fecha;

  ChatMessage({
    required this.sender,
    required this.message,
    required this.fecha,
  });
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatMessage> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String _nombreUsuario = '';
  final String _urlMensajes = 'https://invitaty.com/wp-json/miapi/v1/mensajes';
  final String _urlEnviar =
      'https://invitaty.com/wp-json/miapi/v1/enviar-mensaje';

  @override
  void initState() {
    super.initState();
    _initNombreUsuario();
  }

  Future<void> _initNombreUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    final savedNombre = prefs.getString('nombreUsuario');
    if (savedNombre != null && savedNombre.isNotEmpty) {
      _nombreUsuario = savedNombre;
      _startFetching();
    } else {
      _pedirNombreUsuario();
    }
  }

  void _pedirNombreUsuario() async {
    final nombre = await showDialog<String>(
      context: context,
      builder: (context) {
        final controller = TextEditingController();
        return AlertDialog(
          title: const Text('¿Cómo te llamas?'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Escribe tu nombre'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, controller.text.trim()),
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );

    if (nombre != null && nombre.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('nombreUsuario', nombre);
      _nombreUsuario = nombre;
      _startFetching();
    }
  }

  void _startFetching() {
    _fetchMessages();
    Timer.periodic(const Duration(seconds: 2), (_) => _fetchMessages());
  }

  Future<void> _fetchMessages() async {
    try {
      final response = await http.get(Uri.parse(_urlMensajes));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final newMessages =
            data
                .map((msg) {
                  return ChatMessage(
                    sender: msg['nombre'] ?? 'Desconocido',
                    message: msg['mensaje'],
                    fecha: msg['fecha'],
                  );
                })
                .toList()
                .reversed
                .toList();

        if (mounted) {
          setState(() {
            _messages = newMessages;
          });
          // Autoscroll hacia el último mensaje
          Future.delayed(Duration(milliseconds: 100), () {
            if (_scrollController.hasClients) {
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          });
        }
      }
    } catch (e) {
      print('Error al cargar mensajes: $e');
    }
  }

  Future<void> _sendMessage(String text) async {
    try {
      final response = await http.post(
        Uri.parse(_urlEnviar),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'nombre': _nombreUsuario, 'mensaje': text}),
      );
      if (response.statusCode == 200) {
        _controller.clear();
        _fetchMessages();
      } else {
        print('Error al enviar mensaje: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Widget _buildMessageBubble(ChatMessage msg) {
    final isOwn = msg.sender == _nombreUsuario;
    return Align(
      alignment: isOwn ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: isOwn ? Colors.blue[200] : Colors.grey[300],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment:
              isOwn ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(msg.message, style: const TextStyle(fontSize: 16.0)),
            const SizedBox(height: 4.0),
            Text(
              '${msg.sender} - ${msg.fecha}',
              style: TextStyle(fontSize: 12.0, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat del Grupo')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder:
                  (ctx, index) => _buildMessageBubble(_messages[index]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Escribe un mensaje...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final text = _controller.text.trim();
                    if (text.isNotEmpty) {
                      _sendMessage(text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
