import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AllCharts extends StatelessWidget {
  final List<AllData> allData;
  const AllCharts({super.key, required this.allData});

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      title: ChartTitle(
        text: "All in One",
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
      legend: const Legend(
        alignment: ChartAlignment.center,
        isVisible: true,
        isResponsive: true,
        title: LegendTitle(
          text: "Legend",
          textStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      series: <CircularSeries>[
        RadialBarSeries<AllData, String>(
          dataSource: allData,
          xValueMapper: (AllData data, _) => data.label,
          yValueMapper: (AllData data, _) => data.val,
          trackColor: Colors.greenAccent,
          maximumValue: 100,
          innerRadius: '40%',
          radius: '80%',
          gap: '5%',
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            textStyle: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class AllData {
  final String label;
  final double val;

  AllData({required this.label, required this.val});
}
