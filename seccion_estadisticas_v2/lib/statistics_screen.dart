import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _viewModel=StatisticsScreenViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.loadStats();
  }

  

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 1024;

    return Scaffold(
      body:
          _stats == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Column(
                  children: [
                    isSmallScreen
                        ? Column(
                          children: [
                            Row(
                              children: [
                                Text("Filtros:"),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Fecha de inicio"),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Fecha de fin"),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Empleado"),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Servicios"),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: GeneralInformationWidget(stats: _stats!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: BookingsGraphicWidget(
                                stats: _stats!,
                              ), //TimeProgressWidget GraphicWidget
                            ),
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: EmployeeGraphicWidget(stats: _stats!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: PlatformGraphicWidget(stats: _stats!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: ServicesGraphicWidget(stats: _stats!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: StatusGraphicWidget(stats: _stats!),
                            ),
                          ],
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
                                    right: 12,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text("Fecha inicial"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 24,
                                    bottom: 24,
                                    left: 24,
                                    right: 12,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text("Fecha final"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 24,
                                    bottom: 24,
                                    left: 24,
                                    right: 12,
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
                                    left: 24,
                                    right: 12,
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
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 24,
                                      left: 24,
                                      right: 12,
                                      bottom: 12,
                                    ),
                                    child: GeneralInformationWidget(
                                      stats: _stats!,
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
                                      stats: _stats!,
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
                                    child: EmployeeGraphicWidget(
                                      stats: _stats!,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
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
                                      stats: _stats!,
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
                                      stats: _stats!,
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
                                    child: StatusGraphicWidget(stats: _stats!),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                  ],
                ),
              ),
    );
  }
}
