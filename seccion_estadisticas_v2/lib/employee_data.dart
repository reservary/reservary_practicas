import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:seccion_estadisticas_v2/models/statistics.dart';

class EmployeeData extends StatefulWidget {
  final Statistics stats;
  const EmployeeData({super.key, required this.stats});

  @override
  State<EmployeeData> createState() => _EmployeeDataState();
}

class _EmployeeDataState extends State<EmployeeData> {
  int isTouched = -1;
  List<String> selectedEmployees = [];

  @override
  void initState() {
    super.initState();
    selectedEmployees = [];
  }

  void _showEmployeeSelector() async {
    final List<String> dataEmployee =
        widget.stats.totalBookingsPerEmployee.keys.toList();
    final tempSelected = List<String>.from(selectedEmployees);

    final result = await showDialog<List<String>>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text("Seleccione empleados"),
              content: SingleChildScrollView(
                child: Column(
                  children:
                      dataEmployee.map((emp) {
                        return CheckboxListTile(
                          title: Text(emp),
                          value: tempSelected.contains(emp),
                          onChanged: (bool? checked) {
                            setStateDialog(() {
                              if (checked == true) {
                                tempSelected.add(emp);
                              } else {
                                tempSelected.remove(emp);
                              }
                            });
                          },
                        );
                      }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancelar"),
                ),
                ElevatedButton(
                  onPressed:
                      tempSelected.isEmpty
                          ? null
                          : () {
                            Navigator.pop(context, tempSelected);
                          },
                  child: Text("Aplicar"),
                ),
              ],
            );
          },
        );
      },
    );
    if (result != null) {
      setState(() {
        selectedEmployees = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataEmployee = widget.stats.totalBookingsPerEmployee;
    final filteredEmploye =
        dataEmployee.entries
            .where((entry) => selectedEmployees.contains(entry.key))
            .map((entry) => MapEntry(entry.key, entry.value))
            .toList();
    final List<String> employee =
        filteredEmploye.map((entry) => entry.key).toList();
    final List<int> bookings =
        filteredEmploye.map((entry) => entry.value).toList();
    if (employee.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _showEmployeeSelector,
              child: Text("Seleccionar Empleados"),
            ),
            SizedBox(height: 16),
            Text(
              "No hay empleados seleccionados",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }
    return SizedBox(
      height: 315,
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: _showEmployeeSelector,
                      child: Text("Seleccionar empleados"),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedEmployees.clear();
                        });
                      },
                      child: Text("Restablecer"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (
                          FlTouchEvent event,
                          PieTouchResponse? pieTouchResponse,
                        ) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              isTouched = -1;
                              return;
                            }
                            isTouched =
                                pieTouchResponse
                                    .touchedSection!
                                    .touchedSectionIndex;
                          });
                        },
                      ),
                      centerSpaceRadius: 0,
                      //sectionsSpace: 1,
                      sections: List.generate(filteredEmploye.length, (index) {
                        return PieChartSectionData(
                          value: bookings[index].toDouble(),
                          color: _getColorFromId(employee[index]),
                          radius: isTouched == index ? 120 : 110,
                          borderSide: BorderSide(
                            width: isTouched == index ? 3 : 0,
                          ),
                          badgePositionPercentageOffset: 1.23,
                        );
                      }),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(employee.length, (index) {
                      final idEmploye = employee[index];
                      final color = _getColorFromId(idEmploye);

                      return Row(
                        children: [
                          Container(
                            width: isTouched == index ? 20 : 15,
                            height: isTouched == index ? 20 : 15,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: color,
                            ),
                          ),
                          Text(
                            idEmploye.toUpperCase(),
                            style: TextStyle(
                              fontSize: isTouched == index ? 18 : 14,
                              fontWeight:
                                  isTouched == index
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorFromId(String id) {
    switch (id) {
      case '123456':
        return Colors.blue;
      case '123457':
        return Colors.red;
      case '123458':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
