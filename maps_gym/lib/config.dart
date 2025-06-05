import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'dart:js' as js;

class Config {
  static String get proxyUrl {
    if (kIsWeb) {
      return 'http://localhost:62474';
    } else {
      try {
        final port = File('proxy_port.txt').readAsStringSync().trim();
        return 'http://localhost:$port';
      } catch (e) {
        print('Error leyendo el puerto del proxy: $e');
        return 'http://localhost:62474';
      }
    }
  }

  static String get placesApiBaseUrl {
    if (kIsWeb) {
      return proxyUrl;
    } else {
      return 'https://maps.googleapis.com/maps/api/place';
    }
  }

  static String get googleMapsApiKey {
    // En producción, deberías usar variables de entorno o un archivo de configuración seguro
    return 'AIzaSyAZW-Rn4h5BGgUZzFZXbYKTY6F1T9I8vWI';
  }

  static Future<void> launchUrl(String url) async {
    if (kIsWeb) {
      // En web, usamos js para abrir en una nueva pestaña
      js.context.callMethod('open', [url, '_blank']);
    } else {
      // En móvil, usamos url_launcher
      final uri = Uri.parse(url);
      if (await url_launcher.canLaunchUrl(uri)) {
        await url_launcher.launchUrl(uri);
      } else {
        throw 'No se pudo abrir $url';
      }
    }
  }
} 