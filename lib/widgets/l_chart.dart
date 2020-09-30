import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LChart extends StatelessWidget {
  final List data;
  const LChart({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.2,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: getDots(),
              isCurved: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              colors: [Colors.grey, Colors.white],
              barWidth: 4,
            ),
          ],
        ),
      ),
    );
  }

  List<FlSpot> getDots() {
    List<FlSpot> dots = [];
    double i = 0;
    this.data.forEach((element) {
      dots.add(FlSpot(i++, element));
    });
    return dots;
  }
}
