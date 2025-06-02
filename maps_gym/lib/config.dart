import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class Config {
  static String get proxyUrl {
    if (kIsWeb) {
      return 'http://localhost:62474';
    } else {
      try {
        // Intentamos leer el puerto del archivo de configuración
        final port = File('proxy_port.txt').readAsStringSync().trim();
        return 'http://localhost:$port';
      } catch (e) {
        print('No se pudo leer el puerto del proxy: $e');
        return 'http://localhost:62474';
      }
    }
  }
} 