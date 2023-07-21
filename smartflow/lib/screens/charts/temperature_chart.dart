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
  // last 7 of the current temperature variables - empty map
  Map<dynamic, dynamic> last6Temperatures = {};
  List<TemperatureData> temperatureData = [];
  // subscriptions
  late StreamSubscription<DatabaseEvent> temperatureSubscription;

  List<TemperatureData> convertMapToList(Map<dynamic, dynamic> temperatureMap) {
    List<TemperatureData> resultList = [];
    temperatureMap.forEach((key, value) {
      print("Key: $key, Value: $value");
      resultList.add(
          TemperatureData(date: key.toString(), temperature: value.toDouble()));
    });
    return resultList;
  }

  @override
  void initState() {
    super.initState();

    // Get last 6 temperatures
    DatabaseReference tempRef =
        FirebaseDatabase.instance.ref().child('bulkTemperature');
    temperatureSubscription = tempRef.limitToLast(6).onValue.listen((event) {
      setState(() {
        last6Temperatures = event.snapshot.value as Map<dynamic, dynamic>;
        temperatureData = convertMapToList(last6Temperatures);
      });
      print(
          "Bulk Temperature: ${event.snapshot.value as Map<dynamic, dynamic>}");
      print("Temperature Data: $temperatureData");
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
