import 'package:flutter/material.dart';
import 'package:tabla_reservary/nucleo/app_colores.dart';

class StylesTextos {
  static const TextStyle titulo = TextStyle(
    color: Color(0xFFFFFFFF),
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle fila = TextStyle(
    color: AppColores.textoSecundario,
    fontSize: 20,
  );

  static const TextStyle columna = TextStyle(
    color: AppColores.textoPrimario,
    fontSize: 20,
  );

  static const TextStyle celda = TextStyle(
    color: AppColores.textoPrimario,
    fontSize: 16,
  );

  static const TextStyle celdaSeleccionada = TextStyle(
    color: Colors.white,
    fontSize: 16,
  );
}
