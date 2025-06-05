import 'package:flutter/foundation.dart';
import '../models/gimnasio.dart';

/// Gestiona el estado del gimnasio seleccionado por el usuario
class GymProvider with ChangeNotifier {
  Gimnasio? _selectedGym;

  /// Obtiene el gimnasio actualmente seleccionado
  Gimnasio? get selectedGym => _selectedGym;

  /// Selecciona un nuevo gimnasio como el gimnasio del usuario
  void selectGym(Gimnasio gym) {
    _selectedGym = gym;
    notifyListeners();
  }

  /// Elimina el gimnasio seleccionado
  void removeGym() {
    _selectedGym = null;
    notifyListeners();
  }
} 