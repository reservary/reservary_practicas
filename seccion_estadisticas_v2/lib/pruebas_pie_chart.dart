import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PruebasPieChart extends StatefulWidget {
  const PruebasPieChart({super.key});

  @override
  State<PruebasPieChart> createState() => _PruebasPieChartState();
}

class _PruebasPieChartState extends State<PruebasPieChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: 300,
            height: 300,
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 0,
                sectionsSpace: 1,
                sections: [
                  PieChartSectionData(
                    value: 40,
                    title: "40%",
                    color: Colors.blue,
                    radius: 120
                  ),
                  PieChartSectionData(
                    value: 30,
                    title: "30%",
                    color: Colors.red,
                    radius: 120
                  ),
                  PieChartSectionData(
                    value: 20,
                    title: "20%",
                    color: Colors.green,
                    radius: 120
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
