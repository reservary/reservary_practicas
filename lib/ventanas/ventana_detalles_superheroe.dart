import 'package:flutter/material.dart';
import '../datos/modelo/superhero_detail_response.dart';

class VentanaDetallesSuperheroe extends StatelessWidget {
  final RespuestaDetalleSuperheroe superhero;

  const VentanaDetallesSuperheroe({super.key, required this.superhero});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(superhero.nombre)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              superhero.url,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _construirSeccion(
                    'Estadísticas de Poder',
                    superhero.estadisticasPoder,
                  ),
                  _construirSeccion('Biografía', superhero.biografia),
                  _construirSeccion('Apariencia', superhero.apariencia),
                  _construirSeccion('Trabajo', superhero.trabajo),
                  _construirSeccion('Conexiones', superhero.conexiones),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirSeccion(String titulo, Map<String, dynamic> datos) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        ...datos.entries.map(
          (entrada) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              '${entrada.key}: ${entrada.value}',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
