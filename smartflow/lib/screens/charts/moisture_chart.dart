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
  Map<dynamic, dynamic> last6Moistures = {};
  List<MoistureData> moistureData = [];
  // subscription
  late StreamSubscription<DatabaseEvent> moistureSubscription;

  List<MoistureData> convertMapToList(Map<dynamic, dynamic> moistureMap) {
    List<MoistureData> resultList = [];
    moistureMap.forEach((key, value) {
      print("Key: $key, Value: $value");
      resultList.add(MoistureData(
          location: key.toString(), moistureLevel: value.toDouble()));
    });
    return resultList;
  }

  @override
  void initState() {
    super.initState();

    // Get last 6 moistures
    DatabaseReference moistRef =
        FirebaseDatabase.instance.ref().child('bulkMoisture');
    moistureSubscription = moistRef.limitToFirst(6).onValue.listen((event) {
      setState(() {
        last6Moistures = event.snapshot.value as Map<dynamic, dynamic>;
        moistureData = convertMapToList(last6Moistures);
      });
      print("Bulk Moistures: ${event.snapshot.value as Map<dynamic, dynamic>}");
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
