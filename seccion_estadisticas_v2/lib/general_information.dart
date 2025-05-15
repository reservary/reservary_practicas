import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seccion_estadisticas_v2/models/statistics.dart';

class GeneralInformation extends StatefulWidget {
  const GeneralInformation({super.key});

  @override
  State<GeneralInformation> createState() => _GeneralInformationState();
}

class _GeneralInformationState extends State<GeneralInformation> {
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
    return SizedBox(
      height: 315,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Total reservas:",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w100),
          ),
          Text(
            "${_stats!.totalBookings}",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
          ),
          Text(
            "Total facturado:",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w100),
          ),
          Text(
            "${_stats!.totalBilledAmount}",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}
