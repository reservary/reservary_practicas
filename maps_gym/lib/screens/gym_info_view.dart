import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/gimnasio.dart';
import '../config.dart';
import '../providers/gym_provider.dart';

/// Pantalla que muestra la información detallada de un gimnasio
class GymInfoView extends StatelessWidget {
  final Gimnasio gym;

  const GymInfoView({super.key, required this.gym});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 70, 206, 255),
        foregroundColor: Colors.white,
        title: const Text('Detalles del Gimnasio'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (gym.photoReference != null)
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    '${Config.proxyUrl}/photo?photoreference=${gym.photoReference}',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      print('Error loading image: $error');
                      return Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(Icons.fitness_center, size: 80, color: Colors.grey),
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              gym.nombre,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              gym.direccion,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            if (gym.rating != null) ...[
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text(
                    '${gym.rating}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (gym.totalRatings != null)
                    Text(
                      ' (${gym.totalRatings} valoraciones)',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
            ],
            if (gym.isOpen != null) ...[
              Row(
                children: [
                  Icon(
                    gym.isOpen! ? Icons.check_circle : Icons.cancel,
                    color: gym.isOpen! ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    gym.isOpen! ? 'Abierto' : 'Cerrado',
                    style: TextStyle(
                      color: gym.isOpen! ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
            if (gym.numeroTelefono != null) ...[
              const Text(
                'Teléfono:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(gym.numeroTelefono!),
              const SizedBox(height: 16),
            ],
            if (gym.sitioWeb != null) ...[
              const Text(
                'Sitio web:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(gym.sitioWeb!),
              const SizedBox(height: 16),
            ],
            if (gym.tipos != null && gym.tipos!.isNotEmpty) ...[
              const Text(
                'Servicios:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 8,
                children: gym.tipos!.map((tipo) {
                  return Chip(
                    label: Text(tipo),
                    backgroundColor: Colors.blue[100],
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
            ],
            ElevatedButton(
              onPressed: () {
                // Eliminar el gimnasio seleccionado
                Provider.of<GymProvider>(context, listen: false).removeGym();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Eliminar selección'),
            ),
          ],
        ),
      ),
    );
  }
} 