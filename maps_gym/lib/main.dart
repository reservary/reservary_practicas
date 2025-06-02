import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/map_view_screen.dart';
import 'screens/my_gym_view.dart';
import 'models/gimnasio.dart';
import 'providers/gym_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GymProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 70, 206, 255),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const MapViewScreen(),
          Consumer<GymProvider>(
            builder: (context, gymProvider, child) {
              return const MyGymView();
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Mi Gimnasio',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 70, 206, 255),
        onTap: onItemTapped,
      ),
    );
  }
}