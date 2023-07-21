// ignore_for_file: avoid_print

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HumidityChart extends StatefulWidget {
  const HumidityChart({super.key});

  @override
  State<HumidityChart> createState() => _HumidityChartState();
}

class _HumidityChartState extends State<HumidityChart> {
  Map<dynamic, dynamic> last6Humiditys = {};
  List<HumidityData> humidityData = [];
  // subscriptions
  late StreamSubscription<DatabaseEvent> humiditySubscription;

  List<HumidityData> convertMapToList(Map<dynamic, dynamic> temperatureMap) {
    List<HumidityData> resultList = [];
    temperatureMap.forEach((key, value) {
      print("Key: $key, Value: $value");
      resultList
          .add(HumidityData(label: key.toString(), humidity: value.toDouble()));
    });
    return resultList;
  }

  @override
  void initState() {
    super.initState();

    // Get last 6 moistures
    DatabaseReference humRef =
        FirebaseDatabase.instance.ref().child('bulkHumidity');
    humiditySubscription = humRef.limitToLast(6).onValue.listen((event) {
      setState(() {
        last6Humiditys = event.snapshot.value as Map<dynamic, dynamic>;
        humidityData = convertMapToList(last6Humiditys);
      });
      print("Bulk Humidity: ${event.snapshot.value as Map<dynamic, dynamic>}");
    });
  }

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
