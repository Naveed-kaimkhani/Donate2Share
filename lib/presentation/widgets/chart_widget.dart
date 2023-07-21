import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../domain/models/graph_dots.dart';

class ChartWidget extends StatefulWidget {
  const ChartWidget({super.key});

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  List<SalesData>? _chartData;
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  List<SalesData> getChartData() {
    final List<SalesData> chartData = [
        SalesData(2017, 25),
      SalesData(2018, 12),
      SalesData(2019, 24),
      SalesData(2020, 18),
      SalesData(2021, 30)
    ];
    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      // title: ChartTitle(text: 'Monthly Donation Analysis'),
      // legend: Legend(isVisible: true),
      tooltipBehavior: _tooltipBehavior,
      series: <ChartSeries>[
        LineSeries<SalesData, double>(
            // name: 'Sales',
            dataSource: _chartData!,
            xValueMapper: (SalesData sales, _) => sales.month,
            yValueMapper: (SalesData sales, _) => sales.donation,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            enableTooltip: true)
      ],
      primaryXAxis: NumericAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
      ),
      primaryYAxis: NumericAxis(
          // labelFormat: '{value}M',
          // numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)

          ),
    );
  }
}

class SalesData {
  SalesData(this.month, this.donation);
  final double month;
  final double donation;
}
