import 'package:donation_app/domain/models/donation_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartWidget extends StatefulWidget {
  List<DonationData>? chartData;
  ChartWidget({super.key, required this.chartData});

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    // widget.chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  // List<DonationData> getChartData() {
  //   final List<DonationData> chartData = [
  //     DonationData("july", 25),
  //     DonationData("august", 12),
  //     // Add more data points here as needed
  //   ];
  //   return chartData;
  // }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      // title: ChartTitle(text: 'Monthly Donation Analysis'),
      // legend: Legend(isVisible: true),
      tooltipBehavior: _tooltipBehavior,
      series: <ChartSeries>[
        LineSeries<DonationData, String>(
          // name: 'Sales',
          dataSource: widget.chartData!,
          xValueMapper: (DonationData sales, _) => sales.month,
          yValueMapper: (DonationData sales, _) => sales.donation,
          dataLabelSettings: DataLabelSettings(isVisible: true),
          enableTooltip: true,
        )
      ],
      primaryXAxis:
          CategoryAxis(), // Use CategoryAxis for categorical (String) x-values
      primaryYAxis: NumericAxis(),
    );
  }
}
