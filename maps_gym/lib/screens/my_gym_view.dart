import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/gym_provider.dart';
import '../models/gimnasio.dart';
import 'gym_info_view.dart';
import '../main.dart';
import '../config.dart';

/// Pantalla que muestra el gimnasio seleccionado por el usuario
class MyGymView extends StatelessWidget {
  const MyGymView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GymProvider>(
      builder: (context, gymProvider, child) {
        final Gimnasio? selectedGym = gymProvider.selectedGym;

        if (selectedGym == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'No has seleccionado ningún gimnasio',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navegar a la pantalla del mapa
                    if (context.mounted) {
                      final mainScreen = context.findAncestorStateOfType<MainScreenState>();
                      if (mainScreen != null) {
                        mainScreen.onItemTapped(0);
                      }
                    }
                  },
                  child: const Text('Buscar gimnasios'),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    ClipOval(
                      child: Container(
                        width: 120,
                        height: 120,
                        color: Colors.grey[200],
                        child: selectedGym.photoReference != null
                            ? Image.network(
                                '${Config.proxyUrl}/photo?photoreference=${selectedGym.photoReference}',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  print('Error loading image: $error');
                                  return const Icon(Icons.fitness_center, size: 60, color: Colors.grey);
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
                              )
                            : const Icon(Icons.fitness_center, size: 60, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      selectedGym.nombre,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      selectedGym.direccion,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GymInfoView(gym: selectedGym),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Ver detalles del gimnasio'),
              ),
            ],
          ),
        );
      },
    );
  }
} 