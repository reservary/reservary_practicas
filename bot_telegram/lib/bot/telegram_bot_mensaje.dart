import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// Clase que representa un mensaje del chat
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
  List<ChatMessage> _messages = []; // Lista de mensajes del chat
  final TextEditingController _controller =
      TextEditingController(); // Controlador del campo de texto
  final ScrollController _scrollController =
      ScrollController(); // Controlador del scroll
  String _nombreUsuario = ''; // Nombre del usuario actual
  final String _urlMensajes =
      'https://invitaty.com/wp-json/miapi/v1/mensajes'; // Endpoint para obtener mensajes
  final String _urlEnviar =
      'https://invitaty.com/wp-json/miapi/v1/enviar-mensaje'; // Endpoint para enviar mensajes

  @override
  void initState() {
    super.initState();
    _initNombreUsuario(); // Al iniciar, comprobamos si ya hay un nombre guardado
  }

  // Inicializa el nombre del usuario, pidiéndoselo si no está guardado
  Future<void> _initNombreUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    final savedNombre = prefs.getString('nombreUsuario');
    if (savedNombre != null && savedNombre.isNotEmpty) {
      _nombreUsuario = savedNombre;
      _startFetching(); // Si ya hay nombre, empezamos a obtener mensajes
    } else {
      _pedirNombreUsuario(); // Si no, se lo pedimos
    }
  }

  // Muestra un diálogo para pedir el nombre al usuario
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

    // Guardamos el nombre introducido y empezamos a obtener mensajes
    if (nombre != null && nombre.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('nombreUsuario', nombre);
      _nombreUsuario = nombre;
      _startFetching();
    }
  }

  // Lanza la obtención periódica de mensajes cada 2 segundos
  void _startFetching() {
    _fetchMessages(); // Primero carga inicial
    Timer.periodic(
      const Duration(seconds: 2),
      (_) => _fetchMessages(),
    ); // Luego actualiza cada 2 s
  }

  // Obtiene mensajes del backend y actualiza la lista
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
                .toList(); // Los invertimos para mostrar los más nuevos al final

        if (mounted) {
          setState(() {
            _messages = newMessages;
          });

          // Hacemos scroll automático al final del chat
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

  // Envía un mensaje al servidor
  Future<void> _sendMessage(String text) async {
    try {
      final response = await http.post(
        Uri.parse(_urlEnviar),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'nombre': _nombreUsuario, 'mensaje': text}),
      );
      if (response.statusCode == 200) {
        _controller.clear(); // Limpia el campo de texto
        _fetchMessages(); // Actualiza los mensajes para incluir el nuevo
      } else {
        print('Error al enviar mensaje: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Construye una burbuja de mensaje en el chat
  Widget _buildMessageBubble(ChatMessage msg) {
    final isOwn = msg.sender == _nombreUsuario; // Para diferenciar estilo
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

  // Interfaz principal de la pantalla de chat
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
                    onSubmitted: (text) {
                      final trimmed = text.trim();
                      if (trimmed.isNotEmpty) {
                        _sendMessage(trimmed);
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final text = _controller.text.trim();
                    if (text.isNotEmpty) {
                      _sendMessage(text); // Botón para enviar mensaje
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
