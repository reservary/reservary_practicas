import 'package:flutter/material.dart';
import 'package:progresos_checks/datos/post_model_check.dart';
import 'package:progresos_checks/nucleo/app_colores.dart';
import 'package:progresos_checks/nucleo/estilos_texto.dart';

class DesplegableProgresosChecks extends StatefulWidget {
  final Function(List<Check>) onSelectionChanged;
  const DesplegableProgresosChecks({super.key, required this.onSelectionChanged});

  @override
  State<DesplegableProgresosChecks> createState() =>
      _DesplegableProgresosChecksState();
}

class _DesplegableProgresosChecksState
    extends State<DesplegableProgresosChecks> {
  List<bool> values = [false, false, false, false, false];
  final List<Check> checks = [
    Check.prueba(
      postId: 1,
      createdDate: "2021-01-01",
      modifiedDate: "2021-01-01",
      checkWeight: "90",
    ),
    Check.prueba(
      postId: 2,
      createdDate: "2021-01-01",
      modifiedDate: "2021-01-01",
      checkWeight: "80",
    ),
    Check.prueba(
      postId: 3,
      createdDate: "2021-01-01",
      modifiedDate: "2021-01-01",
      checkWeight: "60",
    ),
    Check.prueba(
      postId: 4,
      createdDate: "2021-01-01",
      modifiedDate: "2021-01-01",
      checkWeight: "50",
    ),
    Check.prueba(
      postId: 5,
      createdDate: "2021-01-01",
      modifiedDate: "2021-01-01",
      checkWeight: "40",
    ),
    
    
    
  ];
  List<Check> getSelectedChecks() {
  return checks.where((check) => values[checks.indexOf(check)]).toList();
}
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColores.fondoComponentes, 
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Checks".toUpperCase(), style: EstilosTexto.titulos),
                    Column(
                      children: List.generate(checks.length, (index) {
                        return Row(
                          children: [
                            Expanded(child: desplegable(checks[index])),
                            Checkbox(
                              value: values[index],
                              onChanged: (bool? newValue) {
                                setState(() {
                                  values[index] = newValue!;
                                  widget.onSelectionChanged(getSelectedChecks());
                                });
                              },
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget desplegable(Check check) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColores.fondoComponentes,
          borderRadius: BorderRadius.circular(8),
          
        ),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Check ${check.postId}", style: EstilosTexto.checks),
            Text("Peso: ${check.checkWeight}", style: EstilosTexto.normal),
          ],
        ),
      ),
    );
  }
}