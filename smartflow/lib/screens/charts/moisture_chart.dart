// ignore_for_file: avoid_print

import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MoistureChart extends StatefulWidget {
  const MoistureChart({super.key});

  @override
  State<MoistureChart> createState() => _MoistureChartState();
}

class _MoistureChartState extends State<MoistureChart> {
  List<MoistureData> moistureData = [];
  Map<dynamic, dynamic> data = {};
  // subscription
  late StreamSubscription<DatabaseEvent> moistureSubscription;

  List<MoistureData> convertMapToList(Map<dynamic, dynamic> moistureMap) {
    List<MoistureData> resultList = [];
    moistureMap.forEach((key, value) {
      print("Key: $key, Value: $value");
      resultList.add(MoistureData(
          timestamp: key.toString(), moistureLevel: value.toDouble()));
    });
    return resultList;
  }

  @override
  void initState() {
    super.initState();

    DatabaseReference dataRef = FirebaseDatabase.instance.ref().child('data');
    moistureSubscription = dataRef.limitToLast(6).onValue.listen((event) {
      setState(() {
        data = event.snapshot.value as Map<dynamic, dynamic>;
      });

      Iterable<dynamic> values = data.values;
      List<dynamic> lstData = values.toList();
      List<int> moist = lstData.map<int>((i) => i['moisture']).toList();
      List<double> timestampList =
          lstData.map<double>((i) => i['timestamp']).toList();

      // time string
      List<String> timeStrings = timestampList.map((timestamp) {
        DateTime dateTime =
            DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).toInt());
        String timeString =
            "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
        return timeString;
      }).toList();

      // set new values
      setState(() {
        moistureData = [
          MoistureData(
              timestamp: timeStrings[0], moistureLevel: moist[0].toDouble()),
          MoistureData(
              timestamp: timeStrings[1], moistureLevel: moist[1].toDouble()),
          MoistureData(
              timestamp: timeStrings[2], moistureLevel: moist[2].toDouble()),
          MoistureData(
              timestamp: timeStrings[3], moistureLevel: moist[3].toDouble()),
          MoistureData(
              timestamp: timeStrings[4], moistureLevel: moist[4].toDouble()),
          MoistureData(
              timestamp: timeStrings[5], moistureLevel: moist[5].toDouble()),
        ];
      });
      print("Moisture Data: $moistureData");
    });
  }

  @override
  void dispose() {
    super.dispose();
    moistureSubscription.cancel();
  }

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
          xValueMapper: (MoistureData data, _) => data.timestamp,
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
  final String timestamp;
  final double moistureLevel;

  MoistureData({required this.timestamp, required this.moistureLevel});
}
