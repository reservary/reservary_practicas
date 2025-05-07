import 'package:flutter/material.dart';

class PruebaFiltro extends StatefulWidget {
  const PruebaFiltro({super.key});

  @override
  State<PruebaFiltro> createState() => _PruebaFiltroState();
}

class _PruebaFiltroState extends State<PruebaFiltro> {
  DateTime? _fechaSeleccionada;

  Future<void> _seleccionarFecha(BuildContext context) async {
    print("Intentando seleccionar fecha");
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025, 12, 31),
    );
    if (picked != null) {
      setState(() {
        _fechaSeleccionada = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prueba de Filtro')),
      body: Column(
        children: [
          Text('Fecha seleccionada: ${_fechaSeleccionada?.toString()}'),
          ElevatedButton(
            onPressed: () {
              print('Botón presionado');
              _seleccionarFecha(context);
            },
            child: const Text('¡Haz clic en mí!'), // Cambié el texto aquí
          ),
        ],
      ),
    );
  }
}
