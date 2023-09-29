import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(
              show: true,
            ),
            minX: 0,
            maxX: 7,
            minY: 0,
            maxY: 6,
            lineBarsData: [
              LineChartBarData(
                spots: [
                  FlSpot(0, 3),
                  FlSpot(1, 1),
                  FlSpot(2, 4),
                  FlSpot(3, 2.5),
                  FlSpot(4, 1.5),
                  FlSpot(5, 3),
                  FlSpot(6, 4),
                ],
                isCurved: true,
                color: Colors.blue,
                barWidth: 4,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(show: false),
              ),
              LineChartBarData(
                spots: [
                  FlSpot(0, 1),
                  FlSpot(1, 3),
                  FlSpot(2, 2),
                  FlSpot(3, 1.5),
                  FlSpot(4, 2.5),
                  FlSpot(5, 3),
                  FlSpot(6, 3),
                ],
                isCurved: true,
                color: Colors.red,
                barWidth: 4,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(show: false),
              )
            ],
          ),
        ),
      ),
    );
  }
}
