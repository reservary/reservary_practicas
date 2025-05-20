import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:seccion_estadisticas_v2/models/statistics.dart';

class PlatformGraphicWidget extends StatefulWidget {
  final Statistics stats;
  const PlatformGraphicWidget({super.key, required this.stats});

  @override
  State<PlatformGraphicWidget> createState() => _PlatformGraphicWidgetState();
}

class _PlatformGraphicWidgetState extends State<PlatformGraphicWidget> {
  int isTouched = -1;

  @override
  Widget build(BuildContext context) {
    final totalBookingsPerPlatform = widget.stats.totalBookingsPerPlatform;
    final List<String> namePlatform = totalBookingsPerPlatform.keys.toList();
    final List<int> numBookings = totalBookingsPerPlatform.values.toList();
    return SizedBox(
      height: 315,
      child: Column(
        children: [
          Text(
            "Reservas por plataforma",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 55,
                  pieTouchData: PieTouchData(
                    touchCallback: (
                      FlTouchEvent event,
                      PieTouchResponse? pieTouchResponse,
                    ) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          return;
                        }
                        isTouched =
                            pieTouchResponse.touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  sections: List.generate(numBookings.length, (index) {
                    return PieChartSectionData(
                      value: numBookings[index].toDouble(),
                      title: isTouched == index ? "${numBookings[index]}" : "",
                      color: _getColorPerPlatform(namePlatform[index]),
                      radius: isTouched == index ? 60 : 50,
                      borderSide: BorderSide(width: isTouched == index ? 3 : 0),
                      badgeWidget: Container(
                        width: isTouched == index ? 65 : 0,
                        height: isTouched == index ? 65 : 0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: isTouched == index ? 2 : 0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _getStringPerPlatform(namePlatform[index]),
                              style: TextStyle(
                                fontSize: isTouched == index ? 11 : 0,
                                fontWeight:
                                    isTouched == index
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      badgePositionPercentageOffset: 1.5,
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

  Color _getColorPerPlatform(String nomPlatform) {
    switch (nomPlatform.toLowerCase()) {
      case 'ios':
        return Colors.grey;
      case 'android':
        return Colors.green;
      case 'adminweb':
        return Colors.blue;
      case 'clienteweb':
        return Colors.lime;
      default:
        return Colors.red;
    }
  }

  String _getStringPerPlatform(String nomPlatform) {
    switch (nomPlatform.toLowerCase()) {
      case 'ios':
        return 'iOS';
      case 'android':
        return 'Android';
      case 'adminweb':
        return 'Admin web';
      case 'clienteweb':
        return 'Cliente web';
      default:
        return 'Not defined';
    }
  }
}
