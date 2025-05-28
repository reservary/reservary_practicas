import 'package:flutter/material.dart';
import 'package:seccion_estadisticas_v2/services/statistic_screen_viewmodel.dart';

class GeneralInformationWidget extends StatefulWidget {
  final StatisticsScreenViewModel viewModel;
  const GeneralInformationWidget({super.key, required this.viewModel});

  @override
  State<GeneralInformationWidget> createState() =>
      _GeneralInformationWidgetState();
}

class _GeneralInformationWidgetState extends State<GeneralInformationWidget> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        final generalInformationstats = widget.viewModel.filteredStats ?? widget.viewModel.originalStats;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Total reservas:",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w100),
            ),
            Text(
              "${generalInformationstats?.totalBookings}",
              style: TextStyle(fontSize: 45, fontWeight: FontWeight.w900),
            ),
            Text(
              "Total facturado:",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w100),
            ),
            Text(
              "${generalInformationstats?.totalBilledAmount}",
              style: TextStyle(fontSize: 45, fontWeight: FontWeight.w900),
            ),
          ],
        );
      },
    );
  }
}
