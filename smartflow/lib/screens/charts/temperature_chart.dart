import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TemperatureChart extends StatelessWidget {
  final List<TemperatureData> temperatureData;
  const TemperatureChart({super.key, required this.temperatureData});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SfCartesianChart(
        title: ChartTitle(
          text: "Temperature",
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
        primaryXAxis: CategoryAxis(),
        series: <ChartSeries>[
          LineSeries<TemperatureData, String>(
            dataSource: temperatureData,
            xValueMapper: (TemperatureData data, _) => data.date,
            yValueMapper: (TemperatureData data, _) => data.temperature,
            color: const Color.fromRGBO(0, 169, 2, 1), // Custom line color
            markerSettings: const MarkerSettings(
              isVisible: true,
              color: Color.fromRGBO(0, 169, 2, 1), // Custom marker color
            ),
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              textStyle: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TemperatureData {
  final String date;
  final double temperature;

  TemperatureData({required this.date, required this.temperature});
}
