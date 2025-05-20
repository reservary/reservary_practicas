import 'package:flutter/material.dart';
import 'package:seccion_estadisticas_v2/models/statistics.dart';

class GeneralInformationWidget extends StatefulWidget {
  final Statistics stats;
  const GeneralInformationWidget({super.key,required this.stats});

  @override
  State<GeneralInformationWidget> createState() => _GeneralInformationWidgetState();
}

class _GeneralInformationWidgetState extends State<GeneralInformationWidget> {
  



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
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w100),
          ),
          Text(
            "${widget.stats.totalBookings}",
            style: TextStyle(fontSize: 45, fontWeight: FontWeight.w900),
          ),
          Text(
            "Total facturado:",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w100),
          ),
          Text(
            "${widget.stats.totalBilledAmount}",
            style: TextStyle(fontSize: 45, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}
