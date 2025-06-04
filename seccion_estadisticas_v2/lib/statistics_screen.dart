import 'package:flutter/material.dart';
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
      widget.viewModel.filteredByDate(_startDate, _endDate);
    }
  }

  void _showEmployeeSelector() async {
    final List<String> employees =
        widget.viewModel.totalBookingsPerEmployee.keys.toList();
    final currentSelection = List<String>.from(
      widget.viewModel.selectedEmployeeIds,
    );

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text("Seleccione los empleados"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:
                      employees.map((employee) {
                        return CheckboxListTile(
                          title: Text(employee),
                          value: currentSelection.contains(employee),
                          onChanged: (bool? checked) {
                            setStateDialog(() {
                              if (checked == true) {
                                currentSelection.add(employee);
                              } else {
                                currentSelection.remove(employee);
                              }
                            });
                            widget.viewModel.selectEmployee(employee);
                          },
                        );
                      }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setStateDialog(() {
                      currentSelection.clear();
                    });
                    widget.viewModel.selectEmployee(null);
                    Navigator.pop(context);
                  },
                  child: const Text("Limpiar"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cerrar"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showServiceSelector() async {
    final List<String> services =
        widget.viewModel.totalBookingsPerService.keys.toList();
    final currentSelection = List<String>.from(
      widget.viewModel.selectedServices,
    );

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text("Seleccione los servicios"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:
                      services.map((service) {
                        return CheckboxListTile(
                          title: Text(service),
                          value: currentSelection.contains(service),
                          onChanged: (bool? checked) {
                            setStateDialog(() {
                              if (checked == true) {
                                currentSelection.add(service);
                              } else {
                                currentSelection.remove(service);
                              }
                            });
                            widget.viewModel.filteredByServices(
                              List<String>.from(currentSelection),
                            );
                          },
                        );
                      }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setStateDialog(() {
                      currentSelection.clear();
                    });
                    widget.viewModel.filteredByServices([]);
                    Navigator.pop(context);
                  },
                  child: const Text("Limpiar"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cerrar"),
                ),
              ],
            );
          },
        );
      },
    );
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

          return SingleChildScrollView(
            child:
                isSmallScreen
                    ? Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 24,
                                bottom:8,
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
                                bottom: 8,
                                left: 6,
                                right: 6,
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  _showEmployeeSelector();
                                },
                                child: Text(
                                  widget.viewModel.selectedEmployeeIds.isEmpty
                                      ? "Empleados"
                                      : "Empleados (${widget.viewModel.selectedEmployeeIds.length})",
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 24,
                                bottom: 8,
                                left: 6,
                                right: 24,
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  _showServiceSelector();
                                },
                                child: Text(
                                  widget.viewModel.selectedServices.isEmpty
                                      ? "Servicios"
                                      : "Servicios (${widget.viewModel.selectedServices.length})",
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 24,
                                bottom: 8,
                                left: 6,
                                right: 24,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _startDate = null;
                                    _endDate = null;
                                  });
                                  widget.viewModel.selectEmployee(null);
                                  widget.viewModel.filteredByServices([]);
                                  widget.viewModel.filteredByDate(null, null);
                                },
                                icon: Icon(Icons.filter_alt_off),
                                tooltip: "Restablecer filtros",
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: GeneralInformationWidget(
                                  viewModel: widget.viewModel,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: BookingsGraphicWidget(
                                  viewModel: widget.viewModel,
                                ),
                              ),
                            ),
                            if (widget.viewModel.selectedEmployeeIds.length !=
                                1) ...[
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.65,
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: EmployeeGraphicWidget(
                                    viewModel: widget.viewModel,
                                  ),
                                ),
                              ),
                            ],
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: PlatformGraphicWidget(
                                  viewModel: widget.viewModel,
                                ),
                              ),
                            ),
                            if (widget.viewModel.selectedServices.length !=
                                1) ...[
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.5,
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: ServicesGraphicWidget(
                                    viewModel: widget.viewModel,
                                  ),
                                ),
                              ),
                            ],
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
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
                    )
                    : Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 24,
                                bottom: 12,
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
                                bottom: 12,
                                left: 6,
                                right: 6,
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  _showEmployeeSelector();
                                },
                                child: Text(
                                  widget.viewModel.selectedEmployeeIds.isEmpty
                                      ? "Empleados"
                                      : "Empleados (${widget.viewModel.selectedEmployeeIds.length})",
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 24,
                                bottom: 12,
                                left: 6,
                                right: 24,
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  _showServiceSelector();
                                },
                                child: Text(
                                  widget.viewModel.selectedServices.isEmpty
                                      ? "Servicios"
                                      : "Servicios (${widget.viewModel.selectedServices.length})",
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 24,
                                bottom: 12,
                                left: 6,
                                right: 24,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _startDate = null;
                                    _endDate = null;
                                  });
                                  widget.viewModel.selectEmployee(null);
                                  widget.viewModel.filteredByServices([]);
                                  widget.viewModel.filteredByDate(null, null);
                                },
                                icon: Icon(Icons.filter_alt_off),
                                tooltip: "Restablecer filtros",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 12,
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
                                    top: 12,
                                    left: 12,
                                    right: 12,
                                    bottom: 12,
                                  ),
                                  child: BookingsGraphicWidget(
                                    viewModel: widget.viewModel,
                                  ),
                                ),
                              ),
                              if (widget.viewModel.selectedEmployeeIds.length !=
                                  1)
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 12,
                                      left: 12,
                                      right: 24,
                                      bottom: 12,
                                    ),
                                    child: EmployeeGraphicWidget(
                                      viewModel: widget.viewModel,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.65,
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
                              if (widget.viewModel.selectedServices.length != 1)
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
                    ),
          );
        },
      ),
    );
  }
}
