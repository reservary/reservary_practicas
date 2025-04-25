import 'package:flutter/material.dart';

class ValidacionNumeroPage extends StatefulWidget {
  const ValidacionNumeroPage({super.key});

  @override
  State<ValidacionNumeroPage> createState() => _ValidacionNumeroPageState();
}

class _ValidacionNumeroPageState extends State<ValidacionNumeroPage> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _binarioController = TextEditingController();
  final TextEditingController _segundoNumeroController = TextEditingController();
  final TextEditingController _resultadoController = TextEditingController();
  final TextEditingController _resultadoBinarioController = TextEditingController();
  String? _errorText;
  String? _errorTextSegundo;
/*Declaracion de funciones*/ 

/*Metodo para validar si el campo esta vacio, si es numerico y si esta entre 1000 y 10000(no incluidos)*/
  bool validacionPrimerNumero(String value) {
    if (value.isEmpty) {
      return false;
    }
    var numero = int.tryParse(value);
    if (numero == null) {
      return false;
    }
    return numero > 1000 && numero < 10000;
  }

/*Metodo para validar si el segundo numero es menor o igual al primero y para pasarlo de String a int, verificando que no sea null*/

  bool validacionSegundoNumero(String value) {
    if (!validacionPrimerNumero(value)) {
      return false;
    }
    final numero1 = int.tryParse(_controller.text);
    final numero2 = int.tryParse(value);
    if (numero1 == null || numero2 == null) {
      return false;
    }
    return numero2 <= numero1;
  }

/*Metodo para pasar un numero a binario con el metodo toRadixString*/
  String pasarBinario(String numero) {
    final valor = int.tryParse(numero);
    if (valor == null) return '';
    return valor.toRadixString(2);
  }
/*El widget para la pantalla de la App*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Binarios'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.lightBlue,
                Colors.white,
              ],
            ),
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /*Campo para escribir el primer numero*/
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Escribe un número',
                hintText: 'Te dejo poner desde 1001 hasta 9999',
                border: const OutlineInputBorder(),
                errorText: _errorText,
              ),
              /*Cambios de estado en funcion de lo que se escriba en el campo*/
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty) {
                    _errorText = 'El campo no puede estar vacío';
                  } else if (!validacionPrimerNumero(value)) {
                    _errorText = 'Debe ser un numero y estar entre 1000 y 10000(no incluidos)';
                  } else {
                    _errorText = null;
                  }
                  /*Validar el segundo número cuando cambia el primero*/
                  if (_segundoNumeroController.text.isNotEmpty) {
                    if (!validacionSegundoNumero(_segundoNumeroController.text)) {
                      _errorTextSegundo = 'El segundo número debe ser menor o igual al primero';
                    } else {
                      _errorTextSegundo = null;
                    }
                  }
                });
              },
            ),
            /*Campo para mostrar el numero en binario*/
            const SizedBox(height: 20),
            TextField(
              controller: _binarioController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Número en binario',
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey,
              ),
            ),
            /*Campo para escribir el segundo numero*/
            const SizedBox(height: 20),
            TextField(
              controller: _segundoNumeroController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Escribe el segundo número',
                hintText: 'Te dejo poner desde 1001 hasta 9999',
                border: const OutlineInputBorder(),
                errorText: _errorTextSegundo,
              ),
              /*Cambios de estado en funcion de lo que se escriba en el campo*/
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty) {
                    _errorTextSegundo = 'El campo no puede estar vacío';
                  } else if (!validacionPrimerNumero(value)) {
                    _errorTextSegundo = 'Debe ser un numero y estar entre 1000 y 10000(no incluidos)';
                  } else if (!validacionSegundoNumero(value)) {
                    _errorTextSegundo = 'El segundo número debe ser menor o igual al primero';
                  } else {
                    _errorTextSegundo = null;
                  }
                });
              },
            ),
            /*Campo para mostrar el resultado de la resta*/
            const SizedBox(height: 20),
            TextField(
              controller: _resultadoController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Resultado de la resta',
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.redAccent,
              ),
            ),
            /*Campo para mostrar el resultado de la resta en binario*/
            const SizedBox(height: 20),
            TextField(
              controller: _resultadoBinarioController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Resultado en binario',
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.lightGreenAccent,
              ),
            ),
            /*Botón para ejecutar los metodos y mostrar los resultados*/
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.grey),
              overlayColor: WidgetStateProperty.all(Colors.green)
              ),
              onPressed: () {
                /*Se ejecuta el metodo para validar los campos y mostrar los resultados*/
                if (validacionPrimerNumero(_controller.text) && validacionSegundoNumero(_segundoNumeroController.text)) {
                  setState(() {
                    _binarioController.text = pasarBinario(_controller.text);
                    
                    // Calcular la resta
                    final numero1 = int.parse(_controller.text);
                    final numero2 = int.parse(_segundoNumeroController.text);
                    final resultado = numero1 - numero2;
                    
                    _resultadoController.text = resultado.toString();
                    _resultadoBinarioController.text = pasarBinario(resultado.toString());
                  });
                  /*TESTEOS Se imprimen los resultados en consola*/
                  print('Número 1: ${_controller.text}');
                  print('Número 1 en binario: ${_binarioController.text}');
                  print('Número 2: ${_segundoNumeroController.text}');
                  print('Resultado: ${_resultadoController.text}');
                  print('Resultado en binario: ${_resultadoBinarioController.text}');
                } else {
                  setState(() {
                    _binarioController.text = '';
                    _resultadoController.text = '';
                    _resultadoBinarioController.text = '';
                  });
                  print('Números inválidos');
                }
              },
              child: const Icon(Icons.arrow_circle_right_rounded, color: Colors.black,),
            ),
          ],
        ),
      ),

    );
  }

} 