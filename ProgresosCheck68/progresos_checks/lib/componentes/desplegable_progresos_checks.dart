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
  late final Map<Check, bool> checkSelections;

  @override
  void initState() {
    super.initState();

    final checks = _getInitialChecks();
    checkSelections = {for (var check in checks) check: false};
  }

  List<Check> _getInitialChecks() {
    return [
      // Tu lista de objetos Check (puedes limpiarla si tiene duplicados)
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
      checkNeck: "42",
      checkChest: "102",
      checkBiceps: "37",
      checkForearm: "27",
      checkWaist: "87",
      checkHip: "97",
      checkThigh: "52",
      checkCalf: "42",
    ),
    Check(
      postId: 3,
      postTitle: "Check 3",
      createdDate: "2021-03-01",
      modifiedDate: "2021-03-01",
      checkWeight: "82",
      checkNeck: "44",
      checkChest: "104",
      checkBiceps: "39",
      checkForearm: "29",
      checkWaist: "89",
      checkHip: "99",
      checkThigh: "54",
      checkCalf: "44",
    ),
    Check(
      postId: 4,
      postTitle: "Check 4",
      createdDate: "2021-04-01",
      modifiedDate: "2021-04-01",
      checkWeight: "80",
      checkNeck: "46",
      checkChest: "106",
      checkBiceps: "41",
      checkForearm: "31",
      checkWaist: "91",
      checkHip: "101",
      checkThigh: "56",
      checkCalf: "46",
    ),
    Check(
      postId: 5,
      postTitle: "Check 5",
      createdDate: "2021-05-01",
      modifiedDate: "2021-05-01",
      checkWeight: "78",
      checkNeck: "48",
      checkChest: "108",
      checkBiceps: "43",
      checkForearm: "33",
      checkWaist: "93",
      checkHip: "103",
      checkThigh: "58",
      checkCalf: "48",
    ),
    Check(
      postId: 6,
      postTitle: "Check 6",
      createdDate: "2021-06-01",
      modifiedDate: "2021-06-01",
      checkWeight: "76",
      checkNeck: "49",
      checkChest: "109",
      checkBiceps: "44",
      checkForearm: "34",
      checkWaist: "94",
      checkHip: "104",
      checkThigh: "59",
      checkCalf: "49",
    ),
    Check(
      postId: 7,
      postTitle: "Check 7",
      createdDate: "2021-07-01",
      modifiedDate: "2021-07-01",
      checkWeight: "74",
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
      postId: 8,
      postTitle: "Check 8",
      createdDate: "2021-08-01",
      modifiedDate: "2021-08-01",
      checkWeight: "72",
      checkNeck: "51",
      checkChest: "111",
      checkBiceps: "46",
      checkForearm: "36",
      checkWaist: "96",
      checkHip: "106",
      checkThigh: "61",
      checkCalf: "51",
    ),
    Check(
      postId: 9,
      postTitle: "Check 9",
      createdDate: "2021-09-01",
      modifiedDate: "2021-09-01",
      checkWeight: "70",
      checkNeck: "52",
      checkChest: "112",
      checkBiceps: "47",
      checkForearm: "37",
      checkWaist: "97",
      checkHip: "107",
      checkThigh: "62",
      checkCalf: "52",
    ),
    Check(
      postId: 10,
      postTitle: "Check 10",
      createdDate: "2021-10-01",
      modifiedDate: "2021-10-01",
      checkWeight: "68",
      checkNeck: "53",
      checkChest: "113",
      checkBiceps: "48",
      checkForearm: "38",
      checkWaist: "98",
      checkHip: "108",
      checkThigh: "63",
      checkCalf: "53",
    ),
     Check(
      postId: 11,
      postTitle: "Check 11",
      createdDate: "2021-11-01",
      modifiedDate: "2021-11-01",
      checkWeight: "67",
      checkNeck: "54",
      checkChest: "114",
      checkBiceps: "49",
      checkForearm: "39",
      checkWaist: "99",
      checkHip: "109",
      checkThigh: "64",
      checkCalf: "54",
    ),
    Check(
      postId: 12,
      postTitle: "Check 12",
      createdDate: "2021-12-01",
      modifiedDate: "2021-12-01",
      checkWeight: "66",
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
      postId: 13,
      postTitle: "Check 13",
      createdDate: "2022-01-01",
      modifiedDate: "2022-01-01",
      checkWeight: "65",
      checkNeck: "56",
      checkChest: "116",
      checkBiceps: "51",
      checkForearm: "41",
      checkWaist: "101",
      checkHip: "111",
      checkThigh: "66",
      checkCalf: "56",
    ),
    Check(
      postId: 14,
      postTitle: "Check 14",
      createdDate: "2022-02-01",
      modifiedDate: "2022-02-01",
      checkWeight: "64",
      checkNeck: "57",
      checkChest: "117",
      checkBiceps: "52",
      checkForearm: "42",
      checkWaist: "102",
      checkHip: "112",
      checkThigh: "67",
      checkCalf: "57",
    ),
    Check(
      postId: 15,
      postTitle: "Check 15",
      createdDate: "2022-03-01",
      modifiedDate: "2022-03-01",
      checkWeight: "63",
      checkNeck: "58",
      checkChest: "118",
      checkBiceps: "53",
      checkForearm: "43",
      checkWaist: "103",
      checkHip: "113",
      checkThigh: "68",
      checkCalf: "58",
    ),
    ];
  }

  List<Check> getSelectedChecks() {
    return checkSelections.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
  }

  List<bool> values = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
 

   @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Text("Checks".toUpperCase(), style: EstilosTexto.titulos, textAlign: TextAlign.center),
          ),
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
                    checkSelections.updateAll((key, value) => marcarTodos);
                    widget.onSelectionChanged(getSelectedChecks());
                  });
                },
              ),
            ],
          ),
          Column(
            children: checkSelections.entries.map((entry) {
              final check = entry.key;
              final isSelected = entry.value;
              return Row(
                children: [
                  Expanded(child: desplegable(check)),
                  Checkbox(
                    value: isSelected,
                    onChanged: (bool? newValue) {
                      setState(() {
                        checkSelections[check] = newValue!;
                        marcarTodos = checkSelections.values.every((v) => v);
                        widget.onSelectionChanged(getSelectedChecks());
                      });
                    },
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
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