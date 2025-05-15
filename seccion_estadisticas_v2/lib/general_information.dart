import 'package:flutter/material.dart';
import 'package:seccion_estadisticas_v2/models/statistics.dart';

class GeneralInformation extends StatefulWidget {
  final Statistics stats;
  const GeneralInformation({super.key,required this.stats});

  @override
  State<GeneralInformation> createState() => _GeneralInformationState();
}

class _GeneralInformationState extends State<GeneralInformation> {
  



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
            "${widget.stats.totalBookings}",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
          ),
          Text(
            "Total facturado:",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w100),
          ),
          Text(
            "${widget.stats.totalBilledAmount}",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}
