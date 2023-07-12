import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MoistureChart extends StatelessWidget {
  final List<MoistureData> moistureData;
  const MoistureChart({super.key, required this.moistureData});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: "Soil Moisture",
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
      primaryXAxis: CategoryAxis(),
      series: <ChartSeries>[
        ColumnSeries<MoistureData, String>(
          dataSource: moistureData,
          xValueMapper: (MoistureData data, _) => data.location,
          yValueMapper: (MoistureData data, _) => data.moistureLevel,
          color: Colors.green, // Custom bar color
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

class MoistureData {
  final String location;
  final double moistureLevel;

  MoistureData({required this.location, required this.moistureLevel});
}
