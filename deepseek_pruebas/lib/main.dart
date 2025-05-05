import 'package:deepseek_pruebas/deepseek_llamadas.dart';

void main() async {
  final servicio = DeepSeekLlamadas();

  final datosUsuario = {
    [
      {
        "user_username": "Prueba",
        "user_birthday": "21-06-1991",
        "user_sex": "Hombre",
        "user_height": "180.00",
        "user_weight": "78.00",
        "user_body": "Ectomorfo",
        "user_goal_weight": "85.01",
        "user_goals": "Musculacion",
        "user_training_level": "3",
        "user_training_place": "Gym",
        "user_equipment": [
          "Banco Plano",
          "Banco Inclinable",
          "Banco Scott",
          "Fitball",
          "Mancuernas",
          "Pesa Rusa",
          "Barra Larga",
          "Barra Z",
          "Barra Romana",
          "Bandas",
          "Polea",
          "Máquina",
          "Otro",
        ],
      },
    ],
  };
  await servicio.generarPlan(datosUsuario as Map<dynamic, dynamic>);
}
