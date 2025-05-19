import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:seccion_estadisticas_v2/models/statistics.dart';

class ServicesData extends StatefulWidget {
  final Statistics stats;
  const ServicesData({super.key, required this.stats});

  @override
  State<ServicesData> createState() => _ServicesDataState();
}

class _ServicesDataState extends State<ServicesData> {
  List<String> selectedServices = [];

  void _showServicesSelector() async {
    final List<String> servicesNames =
        widget.stats.totalBookingsPerService.keys.toList();
    final tempSelected = List<String>.from(selectedServices);

    final result = await showDialog<List<String>>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text("Seleccione los servicios"),
              content: SingleChildScrollView(
                child: Column(
                  children:
                      servicesNames.map((serv) {
                        return CheckboxListTile(
                          title: Text(serv),
                          value: tempSelected.contains(serv),
                          onChanged: (bool? checked) {
                            setStateDialog(() {
                              if (checked == true) {
                                tempSelected.add(serv);
                              } else {
                                tempSelected.remove(serv);
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
        selectedServices = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataServices = widget.stats.totalBookingsPerService;
    final filteredEntries =
        dataServices.entries
            .where((entry) => selectedServices.contains(entry.key))
            .toList();
    final filteredNames = List<String>.from(filteredEntries.map((e) => e.key));
    final filteredValues =
        filteredEntries.map((e) {
          final val = e.value;
          if (val.isNaN || val.isInfinite) return 0.0;
          return val.toDouble();
        }).toList();
    if (filteredNames.isEmpty || filteredValues.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _showServicesSelector,
              child: Text("Seleccionar servicios"),
            ),
            SizedBox(height: 16),
            Text(
              "No hay ningún servicio seleccionado",
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
          Row(
            children: [
              // Expanded(
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: ElevatedButton(
              //       onPressed: _showServicesSelector,
              //       child: Text("Seleccionar servicios"),
              //     ),
              //   ),
              // ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedServices.clear();
                      });
                    },
                    child: Text("Restablecer"),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SizedBox(
              child: BarChart(
                BarChartData(
                  rotationQuarterTurns: 45,
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(
                    show: true,
                    border: Border(
                      top: BorderSide.none,
                      right: BorderSide.none,
                      left: BorderSide(width: 1),
                      bottom: BorderSide(width: 1),
                    ),
                  ),
                  titlesData: FlTitlesData(
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        reservedSize: 50,
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() < 0 ||
                              value.toInt() >= filteredNames.length) {
                            return SizedBox.shrink();
                          }
                          final serviceName = filteredNames[value.toInt()];
                          return Transform.rotate(
                            angle: -math.pi / 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                serviceName,
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  barGroups: List.generate(filteredValues.length, (index) {
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: filteredValues[index],
                          color: Colors.blue,
                          width: 10,
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
