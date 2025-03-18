import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:workout_app/datetime/date_time.dart';

class HeatMapScreen extends StatelessWidget {
  final Map<DateTime, int> datasets;
  final String startDateYYYYMMDD;

  const HeatMapScreen(
      {super.key, required this.datasets, required this.startDateYYYYMMDD});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50.0),
      child: HeatMap(
          startDate: createDateTineObject(startDateYYYYMMDD),
          endDate: DateTime.now().add(const Duration(days: 0)),
          datasets: datasets,
          colorMode: ColorMode.color,
          defaultColor: Colors.grey[200],
          textColor: Colors.black,
          showColorTip: false,
          showText: true,
          scrollable: true,
          size: 33.0,
          colorsets: const {
            1: Colors.green,
          }),
    );
  }
}
