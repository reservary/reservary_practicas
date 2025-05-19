import 'package:progresos_checks/datos/post_model_check.dart';

class GeneradorChecks {
  /// Devuelve una lista de checks simulados con valores fijos
  static List<Check> obtenerChecksEstaticos() {
    return List.generate(
      15,
      (index) => Check(
        postId: index + 1,
        postTitle: "Check ${index + 1}",
        createdDate: "2021-01-${(index + 1).toString().padLeft(2, '0')}",
        modifiedDate: "2021-01-${(index + 1).toString().padLeft(2, '0')}",
        checkWeight: "${90 - index}",
        checkNeck: "${40 + index}",
        checkChest: "${100 + index}",
        checkBiceps: "${35 + index}",
        checkForearm: "${25 + index}",
        checkWaist: "${85 + index}",
        checkHip: "${95 + index}",
        checkThigh: "${50 + index}",
        checkCalf: "${40 + index}",
      ),
    );
  }

  /// Devuelve una lista de objetos Check que representan las diferentes medidas disponibles
  List<Check> generarChecksDeMedidas() {
    const nombresMedidas = [
      "Peso",
      "Cuello",
      "Pecho",
      "Bíceps",
      "Antebrazo",
      "Cintura",
      "Cadera",
      "Muslo",
      "Pantorrilla",
    ];

    return List.generate(
      nombresMedidas.length,
      (index) => Check(
        postId: index,
        postTitle: nombresMedidas[index],
        createdDate: '',
        modifiedDate: '',
        checkWeight: '',
        checkNeck: '',
        checkChest: '',
        checkBiceps: '',
        checkForearm: '',
        checkWaist: '',
        checkHip: '',
        checkThigh: '',
        checkCalf: '',
      ),
    );
  }
}
