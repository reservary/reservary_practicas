
import 'package:progresos_checks/datos/post_model_check.dart';

class ControladorProgresos {
  List<Check> checksSeleccionados = [];

  void actualizarSeleccion(List<Check> seleccionados) {
    checksSeleccionados = seleccionados;
  }
}