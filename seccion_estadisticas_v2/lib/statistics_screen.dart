import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:seccion_estadisticas_v2/bookings_graphic_widget.dart';
import 'package:seccion_estadisticas_v2/general_information_widget.dart';
import 'package:seccion_estadisticas_v2/models/statistics.dart';
import 'package:seccion_estadisticas_v2/employee_graphic_widget.dart';
import 'package:seccion_estadisticas_v2/platform_graphic_widget.dart';
import 'package:seccion_estadisticas_v2/services/statistic_screen_viewmodel.dart';
import 'package:seccion_estadisticas_v2/services_graphic_widget.dart';
import 'package:seccion_estadisticas_v2/status_graphic_widget.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreen();
}

class _StatisticsScreen extends State<StatisticsScreen> {
  DateTime? _startDate;
  DateTime? _endDate;
  final _dateFormat = DateFormat('dd/MM/yyyy');
  final _viewModel = StatisticsScreenViewModel();
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

  @override
  void initState() {
    super.initState();
    //_viewModel.loadStats();
  }

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 1024;

    return Scaffold(
      body:
      //_viewModel.stats == null
      // ? const Center(child: CircularProgressIndicator())
      // : SingleChildScrollView(
      Column(
        children: [
          isSmallScreen
              ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 24,
                      bottom: 24,
                      left: 24,
                      right: 12,
                    ),
                    child: Text("Filtros:"),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 24,
                          bottom: 8,
                          left: 12,
                          right: 24,
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Rango de fechas"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                          left: 12,
                          right: 24,
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Empleado"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 24,
                          left: 12,
                          right: 24,
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Servicios"),
                        ),
                      ),
                    ],
                  ),
                ],
              )
              // Padding(
              //   padding: const EdgeInsets.all(24.0),
              //   child: GeneralInformationWidget(
              //     stats: _viewModel.stats!,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(24.0),
              //   child: BookingsGraphicWidget(
              //     stats: _viewModel.stats!,
              //   ), //TimeProgressWidget GraphicWidget
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(24.0),
              //   child: EmployeeGraphicWidget(
              //     stats: _viewModel.stats!,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(24.0),
              //   child: PlatformGraphicWidget(
              //     stats: _viewModel.stats!,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(24.0),
              //   child: ServicesGraphicWidget(
              //     stats: _viewModel.stats!,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(24.0),
              //   child: StatusGraphicWidget(
              //     stats: _viewModel.stats!,
              //   ),
              // ),
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
                          onPressed: () {},
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
                          onPressed: () {},
                          child: Text("Servicios"),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // Expanded(
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(
                      //       top: 24,
                      //       left: 24,
                      //       right: 12,
                      //       bottom: 12,
                      //     ),
                      //     child: GeneralInformationWidget(
                      //       stats: _viewModel.stats!,
                      //     ),
                      //   ),
                      // ),
                      // Expanded(
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(
                      //       top: 24,
                      //       left: 12,
                      //       right: 12,
                      //       bottom: 12,
                      //     ),
                      //     child: BookingsGraphicWidget(
                      //       stats: _viewModel.stats!,
                      //     ),
                      //   ),
                      // ),
                      // Expanded(
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(
                      //       top: 24,
                      //       left: 12,
                      //       right: 24,
                      //       bottom: 12,
                      //     ),
                      //     child: EmployeeGraphicWidget(
                      //       stats: _viewModel.stats!,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  Row(
                    children: [
                      // Expanded(
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(
                      //       top: 12,
                      //       left: 24,
                      //       right: 12,
                      //       bottom: 24,
                      //     ),
                      //     child: PlatformGraphicWidget(
                      //       stats: _viewModel.stats!,
                      //     ),
                      //   ),
                      // ),
                      // Expanded(
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(
                      //       top: 12,
                      //       left: 12,
                      //       right: 12,
                      //       bottom: 24,
                      //     ),
                      //     child: ServicesGraphicWidget(
                      //       stats: _viewModel.stats!,
                      //     ),
                      //   ),
                      // ),
                      // Expanded(
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(
                      //       top: 12,
                      //       left: 12,
                      //       right: 24,
                      //       bottom: 24,
                      //     ),
                      //     child: StatusGraphicWidget(
                      //       stats: _viewModel.stats!,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
        ],
      ),
    );
  }
}
