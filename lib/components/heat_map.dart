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
            1: Color(0xFF9BE9A8),
            2: Color(0xFF40C463),
            3: Color(0xFF30A14E),
            4: Color(0xFF216E39),
            5: Color(0xFF1E6823),
            6: Color(0xFF166534),
            7: Color(0xFF0B4D2B),
            8: Color(0xFF0A3F24),
            9: Color(0xFF073A1D),
            10: Color(0xFF052F17),
            11: Color(0xFF032A13),
            12: Color(0xFF021F0D),
          }),
    );
  }
}
