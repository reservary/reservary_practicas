import 'dart:io';
import 'Banana.dart';

void principal(List<String> argumentos) {
  saludar("Jose");
}

void saludar(String nombre) {
  var edad = 31;
  print("Hola, $nombre.");
}

void valores() {
  //Tipos fijos
  final String nombre = "David";
  const String clave = "1243";
}

void numeros() {
  // Variables numéricas
  int edad = 31;
  int edadmal = -565421;
  int maatusalen = 010000000000;

  double edad2 = 17.6;
  double edad3 = 17;
  edad2 = 1;

  num edad4 = 16;
  num edad5 = 54;
  edad5 = 1;
}

void booleanos() {
  // Variables booleanas
  bool soyFeliz = true;
  bool soyTriste = false;
}

void cadenas() {
  // Variables de cadena de texto
  String nombre = 'DavidRomero';
  nombre = 'David';
  String edadActual = " 20 años";
  String introduccion = "Soy $nombre y tengo $edadActual";
  print(introduccion);
}

void dinamicos() {
  //Tipo dinámico
  dynamic ejemplo = "Se me puede cambiar";
  print(ejemplo);
  ejemplo = 454;
  print(ejemplo);
}

void conversores() {
  //Conversiones
  String aNumero = "95";
  int numeroParseado = int.parse(aNumero);

  int numeroACadena = 615;
  String cadenaConvertida = numeroACadena.toString();

  String aDouble = "34.23";
  double doubleParseado = double.parse(aDouble);
}

void matematicas() {
  //Operaciones matemáticas
  int a = 2;
  int b = 4;

  int resultado1 = a + b; //Suma
  // int resultado2 = a - b; Resta
  // int resultado3 = a * b; Multiplicación
  // double resultado4 = a / b; División
  // int resultado5 = a ~/ b; División sin decimal
  // int resultado6 = a % b; Módulo

  a += b; //Suma
  a -= b; //Resta
  a *= b; //Multiplicacion

  a++;
  a--;

  print("Resultado es: ${--a}");
}

void ejercicio1() {
  /*
    *Ejercicio 1:

  * Objetivo:
  * Programa en Dart que pida al usuario su año de nacimiento
  * y calcule su edad actual.

  * Pasos a seguir:
  *  Pedir al usuario su año de nacimiento (leerlo como String).
  *  Convertir el año de nacimiento a un número entero.
  *  Calcular la edad restando el año de nacimiento al año actual (2025).
  *  Mostrar el resultado en un mensaje como: "Tienes X años."
  */
  print("Introduce tu año de nacimiento:");
  String fecha = stdin.readLineSync()!;
  const int anoActual = 2025;
  int fechaFormateada = int.parse(fecha);
  int resultado = anoActual - fechaFormateada;
  print("Tienes $resultado años");
}

void ejercicio2() {
  /*
  * Ejercicio 2:

  *  Objetivo:
  *  Programa en Dart que calcule cuánto debe pagar cada persona 
  *  después de dividir la cuenta y agregar una propina.

  * Pasos a seguir:
  * Pedir al usuario el total de la cuenta.
  * Pedir el porcentaje de propina a agregar.
  * Calcular el total a pagar sumando la propina.
  * Pedir el número de personas para dividir la cuenta.
  * Calcular cuánto debe pagar cada persona.
  * Mostrar el resultado 
  */

  double precioTotal = 59.99;
  double propina = 5;
  int numeroPersonas = 3;

  double precioConPropina = (precioTotal * (propina / 100)) + precioTotal;
  String resultadoPrecio = (precioConPropina / numeroPersonas).toStringAsFixed(
    2,
  );

  print(
    "El precio con propina es ${precioConPropina.toStringAsFixed(2)} euros. El total a pagar es de $resultadoPrecio euros por cada cabeza.",
  );
}

void condicionales() {
  int edadUsuario = 19;
  //Opcion 1
  if (edadUsuario >= 18) {
    print("Eres mayor de edad");
  } else {
    print("No eres mayor de edad");
  }

  //Opcion 2
  (edadUsuario >= 18)
      ? print("Eres mayor de edad")
      : print("Eres menor de edad");

  int anosExperiencia = 5;

  if (anosExperiencia > 8) {
    print("Eres un programador experimentado");
  } else if (anosExperiencia >= 5) {
    print("Eres un programador estandar");
  } else {
    print("Eres un programador iniciado");
  }

  print("Introduce el día de la semana:");
  int numeroSemana = int.parse(stdin.readLineSync()!);
  if (numeroSemana == 1) {
    print("Lunes");
  } else if (numeroSemana == 2) {
    print("Martes");
  } else if (numeroSemana == 3) {
    print("Miercoles");
  } else if (numeroSemana == 4) {
    print("Jueves");
  } else if (numeroSemana == 5) {
    print("Viernes");
  } else if (numeroSemana == 6) {
    print("Sábado");
  } else if (numeroSemana == 7) {
    print("Domingo");
  } else {
    print("Pon un dia valido >:(");
  }
}

void ejemplosSwitch() {
  print("Introduce el día de la semana:");
  int numeroSemana = int.parse(stdin.readLineSync()!);

  switch (numeroSemana) {
    case 1:
      print("Lunes");
      break;
    case 2:
      print("Martes");
      break;
    case 3:
      print("Miércoles");
      break;
    case 4:
      print("Jueves");
      break;
    case 5:
      print("Viernes");
      break;
    case 6:
      print("Sábado");
      break;
    case 7:
      print("Domingo");
      break;
    default:
      print("Número no valido >:(");
  }
}

void ejercicio3() {
  /*
  *Ejercicio 3:

  * Objetivo:
  * Programa en Dart que determine si un número ingresado 
  * por el usuario es positivo, negativo o cero.
  */

  print("Introduce un número:");
  int numeroUsuario = int.parse(stdin.readLineSync()!);

  if (numeroUsuario > 0) {
    print("Es positivo");
  } else if (numeroUsuario < 0) {
    print("Es negativo");
  } else {
    print("Es 0");
  }
}

void ejercicio4() {
  /*
*Ejercicio 4:

  * Objetivo:
  * Programa en Dart que reciba un número entre 1 y 12 
  * e imprima el nombre del mes correspondiente del año.
  */

  print("Introduce un número:");
  int numeroUsuario = int.parse(stdin.readLineSync()!);

  switch (numeroUsuario) {
    case 1:
      print("Enero");
    case 2:
      print("Febrero");
    case 3:
      print("Marzo");
    case 4:
      print("Abril");
    case 5:
      print("Mayo");
    case 6:
      print("Junio");
    case 7:
      print("Julio");
    case 8:
      print("Agosto");
    case 9:
      print("Septiembre");
    case 10:
      print("Octubre");
    case 11:
      print("Noviembre");
    case 12:
      print("Diciembre");
    default:
      print("Pon un numero valido >:(");
  }
}

void funcionSimple() {
  print("Alooo");
}

void funcionConEntrada(int a, int b) {
  int resultado = a + b;
  print("El resultado es $resultado");
}

int funcionConSalida() {
  int a = 5;
  int b = 3;
  return a + b;
}

int funcionAmbas1(int a, int b) {
  return a + b;
}

int funcionAmbas2(int a, int b) => a + b;

void funcionValoresOpcionales({String nombre = "Desconocido", int edad = -1}) {
  print("Eres $nombre y tienes $edad");
}

void funcionValoresOpcionales2(String nombre, [int edad = -1]) {
  print("Eres $nombre y tienes $edad");
}

void ejemplosLista() {
  List<String> nombres = ["Jesus", "Vanesa", "Blanca", "Alba", "Jesusito"];
  var nombres2 = ["Oscar", "Ana", "Paco"];

  // print(nombres[5]);
  // print(nombres.first);
  // print(nombres.last);
  // print(nombres.length);
  // print(nombres[nombres.length-1]);
  // nombres[2] = "Jose";
  nombres.insert(1, "Manolito");
  // nombres.add("Paquita");
  nombres.addAll(nombres2);
  // nombres.remove("Jesusito");
  // nombres.removeAt(1);
  // nombres.clear();
  print(nombres);
}

void ejemplosConjunto() {
  Set<String> nombres = {"Manuel", "Mario"};
  Set<String> nombres2 = {"Nicolas", "Roberto"};
  nombres.add("Zacarias");
  nombres.add("zacarias");
  nombres.add("Pilar");
  nombres.remove("zaracarias");
  // nombres.clear();
  // nombres.removeAll(nombres2);
  bool resultadoNombres = nombres.contains("Mario");
  if (nombres.contains("Mario")) {
    print("Mario está invitado");
  } else {
    print("Mario NO está invitado");
  }
  print(nombres.length);

  List<String> nuevosNombres = ["Manuel", "Mario", "Juan"];
  Set<String> nuevoConjNombres = Set.from(nuevosNombres);
  print(nuevoConjNombres);
}

void ejemplosMapa() {
  Map<String, int> gente = {"Manuel": 2, "Mario": 4, "Nicolas": 8};

  gente["Jesus"] = 12;
  gente.addAll({"David": 24, "Laura": 46});
  gente["Luis"] = 87;
  gente.remove("Luis");

  gente.containsKey("Jesus");
  gente.containsValue(12);

  gente.length;
  gente.clear();

  print(gente.values);
}

void bucleLista() {
  List<int> numeros = [2, 4, 6, 8, 12, 3, 1, 89, -56];

  for (var numero in numeros) {
    print("El numero es $numero");
  }

  numeros.forEach((item) {
    print("El numero es $item");
  });

  numeros.forEach(print);
}

void bucleConjunto() {
  Set<int> numeros = {3, 4, 6, 8, 5, 12, 1, 89, -56};

  for (var elemento in numeros) {
    print("EL SET: $elemento");
  }

  numeros.forEach((item) {
    print("El numero es $item");
  });

  numeros.forEach(print);
}

void bucleMapa() {
  Map<String, int> numeros = {"favNumber": 4, "birthday": 20, "address": 345};

  for (var elemento in numeros.entries) {
    print("La clave es ${elemento.key} y el valor es ${elemento.value}");
  }

  numeros.forEach((clave, valor) {
    print("La clave es $clave y el valor $valor");
  });
}

void ejercicio5() {
  /*
  *Ejercicio 5:

  * Objetivo:
  * Programa en Dart que tome una lista de números enteros 
  * y calcule la suma de todos los números pares en la lista.

  * Ejemplo:
  * Entrada: [1, 2, 3, 4, 5, 6]
  * Salida: La suma de los números pares es: 12

  */

  var ejemplo = [2, 5, 7, 7, 8, 12, 13, 15, 18, 440];
  int resultado = 0;

  for (int numero in ejemplo) {
    if (numero % 2 == 0) {
      resultado += numero;
    }
  }
  print("El resultado es $resultado");
}

void ejercicio6() {
  /*
  *Ejercicio 6:

  * Objetivo:
  * Programa en Dart que reciba una lista de palabras con 
  * algunas repetidas y almacene solo las palabras únicas en un Set. 
  * Luego, muestra el conjunto resultante.

  * Ejemplo:
  * Entrada: ["dart", "flutter", "dart", "codigo", "flutter", "movil"]
  * Salida: {dart, flutter, codigo, movil}
*/
  List<String> palabras = [
    "lapiz",
    "cuaderno",
    "goma",
    "bolsa",
    "lapiz",
    "cuaderno",
    "goma",
    "bolsa",
    "lapiz",
    "cuaderno",
    "goma",
    "bolsa",
    "lapiz",
  ];
  Set<String> resultado = {};

  for (var elemento in palabras) {
    resultado.add(elemento);
  }

  var ejemplo = Set.from(palabras);

  print(resultado);
}

void ejercicio7() {
  /*
  *Ejercicio 7:

  * Objetivo:
  * Programa en Dart que reciba una lista de palabras y cuente cuántas 
  * veces aparece cada una, almacenando el resultado en un Map.

  * Ejemplo:
  * Entrada: ["dart", "flutter", "dart", "codigo", "flutter", "movil", "dart"]
  * Salida: {dart: 3, flutter: 2, codigo: 1, movil: 1}
*/

  List<String> palabras = [
    "lapiz",
    "cuaderno",
    "goma",
    "bolsa",
    "lapiz",
    "cuaderno",
    "goma",
    "bolsa",
    "lapiz",
    "cuaderno",
    "goma",
    "bolsa",
    "lapiz",
  ];
  Map<String, int> resultado = {};

  for (var elemento in palabras) {
    if (resultado.containsKey(elemento)) {
      resultado[elemento] = resultado[elemento]! + 1;
    } else {
      resultado[elemento] = 1;
    }
  }
}

void nulabilidad() {
  String? nombre = "Elisa";
  nombre = "";
  nombre = null;
  String ejemplo2 = nombre ?? "invitado";

  nombre ??= "Jose Manuel";

  Banana? prueba = Banana();

  if (nombre != null) {
    print("Hola soy $nombre");
  }

  int? ejemplo = 17;
  ejemplo = null;
}
