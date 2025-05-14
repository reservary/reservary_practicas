import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seccion_estadisticas_v2/bookings_data.dart';
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
    return Scaffold(
      body:
          _stats == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 24,
                            left: 24,
                            bottom: 12,
                            right: 12,
                          ),
                          child: SizedBox(
                            height: 295,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Total reservas:",
                                    style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.w100,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "${_stats!.totalBookings}",
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w900,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "Total facturado:",
                                    style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.w100,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "${_stats!.totalBilledAmount}",
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w900,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 24,
                            bottom: 12,
                            left: 12,
                            right: 12,
                          ),
                          child: BookingsData(),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 24,
                            bottom: 12,
                            left: 12,
                            right: 24,
                          ),
                          child: SizedBox(
                            height: 295,
                            child: EmployeeData(),
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
                            bottom: 24,
                            left: 24,
                            right: 12,
                          ),
                          child: PlatformData(),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 12,
                            bottom: 24,
                            left: 12,
                            right: 12,
                          ),
                          child: ServicesData(),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 12,
                            top: 12,
                            right: 24,
                            bottom: 24,
                          ),
                          child: StatusData(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
    );
  }
}
