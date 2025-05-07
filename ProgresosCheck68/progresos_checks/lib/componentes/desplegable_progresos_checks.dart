import 'package:flutter/material.dart';
import 'package:progresos_checks/datos/post_model_check.dart';
import 'package:progresos_checks/nucleo/app_colores.dart';
import 'package:progresos_checks/nucleo/estilos_texto.dart';

class DesplegableProgresosChecks extends StatefulWidget {
  final Function(List<Check>) onSelectionChanged;
  const DesplegableProgresosChecks({
    super.key,
    required this.onSelectionChanged,
  });

  @override
  State<DesplegableProgresosChecks> createState() =>
      _DesplegableProgresosChecksState();
}

class _DesplegableProgresosChecksState
    extends State<DesplegableProgresosChecks> {
  bool marcarTodos = false;
  List<bool> values = [false, false, false, false, false];
  final List<Check> checks = [
      Check(
    postId: 1,
    postTitle: "Check 1",
    createdDate: "2021-01-01",
    modifiedDate: "2021-01-01",
    checkWeight: "90",
    checkNeck: "40",
    checkChest: "100",
    checkBiceps: "35",
    checkForearm: "25",
    checkWaist: "85",
    checkHip: "95",
    checkThigh: "50",
    checkCalf: "40",
  ),
  Check(
    postId: 2,
    postTitle: "Check 2",
    createdDate: "2021-02-01",
    modifiedDate: "2021-02-01",
    checkWeight: "85",
    checkNeck: "45",
    checkChest: "105",
    checkBiceps: "40",
    checkForearm: "30",
    checkWaist: "90",
    checkHip: "100",
    checkThigh: "55",
    checkCalf: "45",
  ),
  Check(
    postId: 3,
    postTitle: "Check 3",
    createdDate: "2021-03-01",
    modifiedDate: "2021-03-01",
    checkWeight: "80",
    checkNeck: "50",
    checkChest: "110",
    checkBiceps: "45",
    checkForearm: "35",
    checkWaist: "95",
    checkHip: "105",
    checkThigh: "60",
    checkCalf: "50",
  ),
  Check(
    postId: 4,
    postTitle: "Check 4",
    createdDate: "2021-04-01",
    modifiedDate: "2021-04-01",
    checkWeight: "75",
    checkNeck: "55",
    checkChest: "115",
    checkBiceps: "50",
    checkForearm: "40",
    checkWaist: "100",
    checkHip: "110",
    checkThigh: "65",
    checkCalf: "55",
  ),
  Check(
    postId: 5,
    postTitle: "Check 5",
    createdDate: "2021-05-01",
    modifiedDate: "2021-05-01",
    checkWeight: "70",
    checkNeck: "60",
    checkChest: "120",
    checkBiceps: "55",
    checkForearm: "45",
    checkWaist: "105",
    checkHip: "115",
    checkThigh: "70",
    checkCalf: "60",
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
                    Container(
                      width: double.infinity,
                      child: Text("Checks".toUpperCase(), style: EstilosTexto.titulos, textAlign: TextAlign.center,)),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Marcar todos", style: EstilosTexto.checks),
                          ),
                        ),
                        Checkbox(
                          value: marcarTodos,
                          onChanged: (bool? newValue) {
                            setState(() {
                              marcarTodos = newValue!;
                              values = List.generate(
                                values.length,
                                (index) => marcarTodos,
                              );
                              widget.onSelectionChanged(getSelectedChecks());
                            });
                          },
                        ),
                      ],
                    ),
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
                                  marcarTodos = values.every((val) => val);
                                  widget.onSelectionChanged(
                                    getSelectedChecks(),
                                  );
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
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColores.fondoComponentes,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Check ${check.postId}", style: EstilosTexto.checks),
            Text("Fecha: ${check.createdDate}", style: EstilosTexto.normal),
            
            
          ],
        ),
      ),
    );
  }
}
