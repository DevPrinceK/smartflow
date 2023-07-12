import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HumidityChart extends StatelessWidget {
  final List<HumidityData> humidityData;
  const HumidityChart({super.key, required this.humidityData});

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      title: ChartTitle(
        text: "Humidity",
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
        RadialBarSeries<HumidityData, String>(
          dataSource: humidityData,
          xValueMapper: (HumidityData data, _) => data.label,
          yValueMapper: (HumidityData data, _) => data.humidity,
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

class HumidityData {
  final String label;
  final double humidity;

  HumidityData({required this.label, required this.humidity});
}
