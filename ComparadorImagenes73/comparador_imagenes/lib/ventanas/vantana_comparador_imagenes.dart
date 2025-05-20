import 'package:flutter/material.dart';
import 'package:comparador_imagenes/componentes/comparador_imagenes.dart';

class VentanaComparadorImagenes extends StatefulWidget {
  const VentanaComparadorImagenes({super.key});

  @override
  State<VentanaComparadorImagenes> createState() => _VentanaComparadorImagenesState();
}

class _VentanaComparadorImagenesState extends State<VentanaComparadorImagenes> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          const Text(
            "Comparador Imagenes",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Text("Imagen 1:"),
                  Image.asset('assets/imagenes/fuerte.png', width: 150),
                ],
              ),
              const SizedBox(width: 32),
              Column(
                children: [
                  const Text("Imagen 2:"),
                  Image.asset('assets/imagenes/gordo.png', width: 150),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ComparadorImagenes(escala: 0.5),
          ),
        ],
      ),
    );
  }
}
