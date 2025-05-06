import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  double _numero1 = 0;
  double _numero2 = 0;
  double _resultado = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Calculadora"),
        ),
        body: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: const Color(0xFFCCDFEE),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 8),
                            child: Text("Primer numero"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 160,
                              right: 160,
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Ingrese el primer numero",
                              ),
                              onChanged: (num1){
                                _numero1=double.parse(num1);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: const Color(0xFFCCDFEE),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 8),
                            child: Text("Segundo numero"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 160,
                              right: 160,
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Ingrese el segundo numero",
                              ),
                              onChanged: (num2){
                                _numero2=double.parse(num2);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _resultado = sumar(_numero1, _numero2);
                          });
                        },
                        child: Text("Sumar"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _resultado = restar(_numero1, _numero2);
                          });
                        },
                        child: Text("Restar"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _resultado = multiplicar(_numero1, _numero2);
                          });
                        },
                        child: Text("Multiplicar"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _resultado = dividir(_numero1, _numero2);
                          });
                        },
                        child: Text("Dividir"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCCDFEE),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        "$_resultado",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
  }
}

double sumar(double a, double b) => a + b;
double restar(double a, double b) => a - b;
double multiplicar(double a, double b) => a * b;
double dividir(double a, double b) => a / b;