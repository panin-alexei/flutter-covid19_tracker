import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BChart extends StatelessWidget {
  final List<double> barData;
  final List barLabels;
  final Color color;
  const BChart({Key key, this.barData, this.barLabels, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double minVal = this.barData.reduce(min).toDouble();
    return AspectRatio(
      aspectRatio: 1.7,
      child: BarChart(
        BarChartData(
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: Colors.white,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  return BarTooltipItem(
                      (rod.y - 1 + minVal - minVal * 0.1).toInt().toString(),
                      TextStyle(color: color));
                }),
          ),
          barGroups: getBarGroups(),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: SideTitles(
              showTitles: false,
            ),
            bottomTitles: SideTitles(
              showTitles: true,
              getTitles: getLabels,
              textStyle: TextStyle(
                color: Color(0xFF7589A2),
                fontSize: 10,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
        ),
      ),
    );
  }

  getBarGroups() {
    double minVal = this.barData.reduce(min).toDouble();
    List<BarChartGroupData> barChartGroups = [];
    barData.asMap().forEach(
          (i, value) => barChartGroups.add(
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  y: value - minVal + minVal * 0.1,
                  //This is not the proper way, this is just for demo
                  color: color,
                  width: 16,
                )
              ],
            ),
          ),
        );
    return barChartGroups;
  }

  String getLabels(double value) {
    return barLabels[value.toInt()];
  }
}
