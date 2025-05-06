import 'package:coffe_front/features/demand/presentation/viewmodels/demand_view_model.dart';
import 'package:coffe_front/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DemandChart extends ConsumerStatefulWidget {
  final List<String> labels;
  final List<double> quantities;
  final Function predictFunction;
  final bool predict;

  const DemandChart({
    super.key,
    required this.labels,
    required this.quantities,
    required this.predictFunction,
    required this.predict,
  });

  @override
  ConsumerState<DemandChart> createState() => _DemandChartState();
}

class _DemandChartState extends ConsumerState<DemandChart> {
  int? selectedIndex;

  double maxY = 0;
  double interval = 100;

  @override
  void initState() {
    super.initState();
    if (widget.labels.isNotEmpty && widget.quantities.isNotEmpty) {
      calculateYAxis();
    }
  }

  void calculateYAxis() {
    double maxQuantity = widget.quantities.reduce((a, b) => a > b ? a : b);

    if (maxQuantity <= 10) {
      maxY = 10;
      interval = 2;
    } else if (maxQuantity <= 50) {
      maxY = (maxQuantity / 10).ceil() * 10;
      interval = maxY / 5;
    } else if (maxQuantity <= 100) {
      maxY = (maxQuantity / 20).ceil() * 20;
      interval = maxY / 5;
    } else {
      maxY = (maxQuantity / 50).ceil() * 50;
      interval = maxY / 5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      width: 360,
      height: 378,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.bar_chart, size: 28),
                  SizedBox(width: 8),
                  Text(
                    'Demand',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              if (widget.labels.isNotEmpty && widget.quantities.isNotEmpty)
                ElevatedButton(
                  onPressed: () {
                    widget.predictFunction();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsetsDirectional.all(10),
                    backgroundColor:
                        widget.predict ? Colors.blue : Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),

                      side: BorderSide(
                        color: widget.predict ? Colors.white : Colors.blue,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text(
                    "Predict 3 days from today",
                    style: TextStyle(fontSize: 10),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          const Text('Top selling Items', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 20),
          if (widget.labels.isNotEmpty && widget.quantities.isNotEmpty)
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: maxY,
                  minY: 0,
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 35,
                        interval: interval,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(fontSize: 12),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 32,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 &&
                              value.toInt() < widget.labels.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Transform.rotate(
                                angle: -0.3, // rotate labels around -28 degrees
                                child: Text(
                                  widget.labels[value.toInt()],
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ), // smaller font
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2, // allow two lines if needed
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  barGroups: List.generate(
                    widget.labels.length,
                    (index) => makeGroupData(
                      index,
                      widget.quantities[index],
                      isSelected: index == selectedIndex,
                    ),
                  ),
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (group) => ColorManager.background,
                      tooltipPadding: EdgeInsets.all(2),
                      tooltipMargin: 8,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          rod.toY.toStringAsFixed(1),
                          const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        );
                      },
                    ),
                    touchCallback: (FlTouchEvent event, barTouchResponse) {
                      if (!event.isInterestedForInteractions ||
                          barTouchResponse == null ||
                          barTouchResponse.spot == null) {
                        return;
                      }
                      setState(() {
                        selectedIndex =
                            barTouchResponse.spot!.touchedBarGroupIndex;
                      });
                    },
                  ),
                ),
              ),
            ),
          if (widget.labels.isEmpty && widget.quantities.isEmpty)
            Expanded(
              child: Center(
                child: Text(
                  "No data available",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              ref.read(demandProvider.notifier).datePicked,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y, {bool isSelected = false}) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 30,
          borderRadius: BorderRadius.circular(6),
          color: isSelected ? Colors.blue[700] : Colors.grey.shade300,
        ),
      ],
      showingTooltipIndicators: isSelected ? [0] : [],
    );
  }
}
