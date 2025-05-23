import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seccion_estadisticas_v2/bookings_graphic_widget.dart';
import 'package:seccion_estadisticas_v2/general_information_widget.dart';
import 'package:seccion_estadisticas_v2/employee_graphic_widget.dart';
import 'package:seccion_estadisticas_v2/platform_graphic_widget.dart';
import 'package:seccion_estadisticas_v2/services/statistic_screen_viewmodel.dart';
import 'package:seccion_estadisticas_v2/services_graphic_widget.dart';
import 'package:seccion_estadisticas_v2/status_graphic_widget.dart';

class StatisticsScreen extends StatefulWidget {
  final StatisticsScreenViewModel viewModel;
  const StatisticsScreen({super.key, required this.viewModel});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreen();
}

class _StatisticsScreen extends State<StatisticsScreen> {
  List<String> selectedEmployees = [];
  List<String> selectedEServices = [];
  DateTime? _startDate;
  DateTime? _endDate;
  final _dateFormat = DateFormat('dd/MM/yyyy');
  String? employeeId;

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? selectedRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDateRange:
          _startDate != null && _endDate != null
              ? DateTimeRange(start: _startDate!, end: _endDate!)
              : DateTimeRange(
                start: DateTime(2025, 01, 01),
                end: DateTime.now(),
              ),
      initialEntryMode: DatePickerEntryMode.input,
      helpText: "Selecciona el rango",
      locale: Locale("es", "ES"),
    );
    if (selectedRange != null) {
      setState(() {
        _startDate = selectedRange.start;
        _endDate = selectedRange.end;
      });
    }
  }

  void _showEmployeeSelector() async {
    final List<String> employees =
        widget.viewModel.totalBookingsPerEmployee.keys.toList();
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
                      employees.map((emp) {
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
        if(result.isEmpty){
          widget.viewModel.filteredEmployee(null);
        }else{
          widget.viewModel.filteredEmployee(result.first);
        }
      });
    }
  }

  void _showServiceSelector() async {
    final List<String> services =
        widget.viewModel.totalBookingsPerService.keys.toList();
    final tempSelected = List<String>.from(selectedEServices);
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
                      services.map((emp) {
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
        selectedEServices = result;
        if(result.isEmpty){
          widget.viewModel.filteredByServices(0);
        }else{
          widget.viewModel.filteredByServices(int.parse(result.first));
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.viewModel.loadStats();
  }

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 1024;

    return Scaffold(
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, _) {
          final originalStats = widget.viewModel.originalStats;

          if (originalStats == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return isSmallScreen
              ? SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Text("Filtros:"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 24,
                            bottom: 24,
                            left: 24,
                            right: 6,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              _selectDateRange(context);
                            },
                            child: Text("Fechas"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 24,
                            bottom: 24,
                            left: 6,
                            right: 6,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              _showEmployeeSelector();
                            },
                            child: Text("Empleado"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 24,
                            bottom: 24,
                            left: 6,
                            right: 24,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              _showServiceSelector();
                            },
                            child: Text("Servicios"),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 400,
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: GeneralInformationWidget(
                              viewModel: widget.viewModel,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 400,
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: BookingsGraphicWidget(
                              viewModel: widget.viewModel,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 400,
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: EmployeeGraphicWidget(
                              viewModel: widget.viewModel,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 400,
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: PlatformGraphicWidget(
                              viewModel: widget.viewModel,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 400,
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: ServicesGraphicWidget(
                              viewModel: widget.viewModel,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 400,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: StatusGraphicWidget(
                              viewModel: widget.viewModel,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
              : Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text("Filtros:"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 24,
                          bottom: 24,
                          left: 24,
                          right: 6,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            _selectDateRange(context);
                          },
                          child: Text("Fechas"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 24,
                          bottom: 24,
                          left: 6,
                          right: 6,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            _showEmployeeSelector();
                          },
                          child: Text("Empleado"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 24,
                          bottom: 24,
                          left: 6,
                          right: 24,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            _showServiceSelector();
                          },
                          child: Text("Servicios"),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 24,
                              left: 24,
                              right: 12,
                              bottom: 12,
                            ),
                            child: GeneralInformationWidget(
                              viewModel: widget.viewModel,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 24,
                              left: 12,
                              right: 12,
                              bottom: 12,
                            ),
                            child: BookingsGraphicWidget(
                              viewModel: widget.viewModel,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 24,
                              left: 12,
                              right: 24,
                              bottom: 12,
                            ),
                            child: SizedBox(
                              height: 300,
                              child: EmployeeGraphicWidget(
                                viewModel: widget.viewModel,
                              ),
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
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 12,
                              left: 24,
                              right: 12,
                              bottom: 24,
                            ),
                            child: PlatformGraphicWidget(
                              viewModel: widget.viewModel,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 12,
                              left: 12,
                              right: 12,
                              bottom: 24,
                            ),
                            child: ServicesGraphicWidget(
                              viewModel: widget.viewModel,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 12,
                              left: 12,
                              right: 24,
                              bottom: 24,
                            ),
                            child: StatusGraphicWidget(
                              viewModel: widget.viewModel,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
        },
      ),
    );
  }
}
