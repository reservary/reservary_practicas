import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/gimnasio.dart';
import '../config.dart';
import '../providers/gym_provider.dart';
import '../main.dart';

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
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        child: Stack(
                          children: [
                            InteractiveViewer(
                              minScale: 0.5,
                              maxScale: 4.0,
                              child: Image.network(
                                '${Config.proxyUrl}/photo?photoreference=${gym.photoReference}',
                                fit: BoxFit.contain,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  print('Error loading image: $error');
                                  return const Center(
                                    child: Icon(Icons.error_outline,
                                        color: Colors.red, size: 50),
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: IconButton(
                                icon: const Icon(Icons.close,
                                    color: Colors.white, size: 30),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.9,
                          maxHeight: 300,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            '${Config.proxyUrl}/photo?photoreference=${gym.photoReference}',
                            fit: BoxFit.contain,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              print('Error loading image: $error');
                              return const Center(
                                child: Icon(Icons.error_outline,
                                    color: Colors.red),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.fullscreen,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
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
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (gym.isOpen != null) ...[
                    Row(
                      children: [
                        Icon(
                          gym.isOpen! ? Icons.check_circle : Icons.cancel,
                          color: gym.isOpen! ? Colors.green : Colors.red,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          gym.isOpen! ? 'Abierto ahora' : 'Cerrado',
                          style: TextStyle(
                            color: gym.isOpen! ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    const Row(
                      children: [
                        Icon(Icons.help_outline, color: Colors.grey, size: 24),
                        SizedBox(width: 8),
                        Text(
                          'Estado no disponible',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (gym.horarios != null && gym.horarios!.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'Horarios de apertura:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...gym.horarios!.map((horario) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              const Icon(Icons.access_time,
                                  size: 16, color: Colors.grey),
                              const SizedBox(width: 8),
                              Text(
                                horario,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        )),
                  ] else ...[
                    const SizedBox(height: 16),
                    const Text(
                      'Horarios de apertura:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Horarios no disponibles',
                      style: TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),
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
              InkWell(
                onTap: () => Config.launchUrl(gym.sitioWeb!),
                child: Text(
                  gym.sitioWeb!,
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            ElevatedButton(
              onPressed: () {
                Provider.of<GymProvider>(context, listen: false).removeGym();
                final mainScreen =
                    context.findAncestorStateOfType<MainScreenState>();
                if (mainScreen != null) {
                  mainScreen.onItemTapped(0);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Ya no voy a este gimnasio',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
