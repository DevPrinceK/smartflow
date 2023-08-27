// ignore_for_file: avoid_print

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TemperatureChart extends StatefulWidget {
  const TemperatureChart({super.key});

  @override
  State<TemperatureChart> createState() => _TemperatureChartState();
}

class _TemperatureChartState extends State<TemperatureChart> {
  List<TemperatureData> temperatureData = [];
  Map<dynamic, dynamic> data = {};
  // subscriptions
  late StreamSubscription<DatabaseEvent> temperatureSubscription;

  @override
  void initState() {
    super.initState();
    DatabaseReference dataRef = FirebaseDatabase.instance.ref().child('data');
    temperatureSubscription = dataRef.limitToLast(6).onValue.listen((event) {
      setState(() {
        data = event.snapshot.value as Map<dynamic, dynamic>;
      });

      Iterable<dynamic> values = data.values;
      List<dynamic> lstData = values.toList();
      List<int> temps = lstData.map<int>((i) => i['temperature']).toList();
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
        temperatureData = [
          TemperatureData(
              date: timeStrings[0], temperature: temps[0].toDouble()),
          TemperatureData(
              date: timeStrings[1], temperature: temps[1].toDouble()),
          TemperatureData(
              date: timeStrings[2], temperature: temps[2].toDouble()),
          TemperatureData(
              date: timeStrings[3], temperature: temps[3].toDouble()),
          TemperatureData(
              date: timeStrings[4], temperature: temps[4].toDouble()),
          TemperatureData(
              date: timeStrings[5], temperature: temps[5].toDouble()),
        ];
      });
    });
    // End of init state
  }

  @override
  void dispose() {
    super.dispose();
    temperatureSubscription.cancel();
  }

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
