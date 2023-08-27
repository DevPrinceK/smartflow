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
  List<HumidityData> humidityData = [];
  Map<dynamic, dynamic> data = {};
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

    // Get last 100 data
    DatabaseReference dataRef = FirebaseDatabase.instance.ref().child('data');
    humiditySubscription = dataRef.limitToLast(6).onValue.listen((event) {
      setState(() {
        data = event.snapshot.value as Map<dynamic, dynamic>;
      });
      Iterable<dynamic> values = data.values;
      List<dynamic> lstData = values.toList();
      List<int> temps = lstData.map<int>((i) => i['temperature']).toList();
      List<int> humids = lstData.map<int>((i) => i['humidity']).toList();
      List<int> moists = lstData.map<int>((i) => i['moisture']).toList();
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

      setState(() {
        humidityData = [
          HumidityData(label: timeStrings[0], humidity: humids[0].toDouble()),
          HumidityData(label: timeStrings[1], humidity: humids[1].toDouble()),
          HumidityData(label: timeStrings[2], humidity: humids[2].toDouble()),
          HumidityData(label: timeStrings[3], humidity: humids[3].toDouble()),
          HumidityData(label: timeStrings[4], humidity: humids[4].toDouble()),
          HumidityData(label: timeStrings[5], humidity: humids[5].toDouble()),
        ];
      });

      // print("Data Response: ${event.snapshot.value as Map<dynamic, dynamic>}");
      print("Data Response: $data");
      print("Temps: $temps");
      print("Humids: $humids");
      print("Moists: $moists");
      print("Timestamps: $timestampList");
      print("TimeStrings: $timeStrings");
    });
  }

  @override
  void dispose() {
    super.dispose();
    humiditySubscription.cancel();
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
