import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RevenueExpenseChart extends StatelessWidget {
  final List<double> revenues;
  final List<double> expenses;
  final List<String> labels; // e.g. ["Jan", "Feb", "Mar", ...]

  const RevenueExpenseChart({
    Key? key,
    required this.revenues,
    required this.expenses,
    required this.labels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: (revenues + expenses).reduce((a, b) => a > b ? a : b) * 1.2,
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                final index = value.toInt();
                return SideTitleWidget(
                  meta: meta,
                  child: Text(
                    labels[index],
                    style: const TextStyle(fontSize: 10),
                  ),
                );
              },
              reservedSize: 30,
            ),
          ),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: List.generate(revenues.length, (index) {
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: expenses[index],
                color: Colors.redAccent,
                width: 5,
                borderRadius: BorderRadius.circular(2),
              ),
              BarChartRodData(
                toY: revenues[index],
                color: Colors.green,
                width: 5,
                borderRadius: BorderRadius.circular(2),
              ),
            ],
            barsSpace: 1,
          );
        }),
      ),
    );
  }
}
