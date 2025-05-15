import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seccion_estadisticas_v2/bookings_data.dart';
import 'package:seccion_estadisticas_v2/general_information.dart';
import 'package:seccion_estadisticas_v2/models/statistics.dart';
import 'package:seccion_estadisticas_v2/employee_data.dart';
import 'package:seccion_estadisticas_v2/platform_data.dart';
import 'package:seccion_estadisticas_v2/services_data.dart';
import 'package:seccion_estadisticas_v2/status_data.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreen();
}

class _StatisticsScreen extends State<StatisticsScreen> {
  Statistics? _stats;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final jsonString = await rootBundle.loadString('assets/data/data.json');
    final jsonMap = jsonDecode(jsonString);
    setState(() {
      _stats = Statistics.fromJson(jsonMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 700;

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
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: GeneralInformation(stats: _stats!,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: BookingsData(stats: _stats!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: EmployeeData(stats: _stats!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: PlatformData(stats: _stats!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: ServicesData(stats: _stats!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: StatusData(stats: _stats!),
                            ),
                          ],
                        )
                        : Column(
                          children: [
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
                                    child: GeneralInformation(stats: _stats!,),
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
                                    child: BookingsData(stats: _stats!),
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
                                    child: EmployeeData(stats: _stats!),
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
                                    child: PlatformData(stats: _stats!),
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
                                    child: ServicesData(stats: _stats!),
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
                                    child: StatusData(stats: _stats!),
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
