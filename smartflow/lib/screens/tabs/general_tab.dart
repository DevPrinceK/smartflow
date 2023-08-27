// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

class GeneralTab extends StatefulWidget {
  final Widget currentChart;
  const GeneralTab({
    super.key,
    required this.currentChart,
  });

  @override
  State<GeneralTab> createState() => _GeneralTabState();
}

class _GeneralTabState extends State<GeneralTab> {
  // current variables
  String currentTemperature = "0";
  String currentHumidity = "0";
  String currentMoisture = "0";
  String currentCrop = '---';
  String currentGrowthStage = '---';
  Map<dynamic, dynamic> data = {};
  // subscriptions
  late StreamSubscription<DatabaseEvent> temperatureSubscription;
  late StreamSubscription<DatabaseEvent> humiditySubscription;
  late StreamSubscription<DatabaseEvent> moistureSubscription;
  late StreamSubscription<DatabaseEvent> cropSubscription;
  late StreamSubscription<DatabaseEvent> growthSubscription;
  late StreamSubscription<dynamic> dataSubscription;

  @override
  void initState() {
    super.initState();
    // all data reference - realtime database
    DatabaseReference dataRef = FirebaseDatabase.instance.ref().child('data');
    dataSubscription = dataRef.limitToLast(2).onValue.listen((event) {
      setState(() {
        data = event.snapshot.value as Map<dynamic, dynamic>;
      });

      //
      Iterable<dynamic> values = data.values;
      List<dynamic> lstData = values.toList();
      List<int> temps = lstData.map<int>((i) => i['temperature']).toList();
      List<int> moist = lstData.map<int>((i) => i['moisture']).toList();
      List<int> hum = lstData.map<int>((i) => i['humidity']).toList();

      setState(() {
        currentTemperature = temps[0].toString();
        currentHumidity = hum[0].toString();
        currentMoisture = moist[0].toString();
      });
    });

    // crop reference - realtime database
    DatabaseReference cropRef = FirebaseDatabase.instance.ref().child('crop');
    cropSubscription = cropRef.onValue.listen((event) {
      setState(() {
        currentCrop = event.snapshot.value.toString();
      });
      print("Current Crop: ${event.snapshot.value.toString()}");
    });

    // crop reference - realtime database
    DatabaseReference cropGrowthRef =
        FirebaseDatabase.instance.ref().child('stage');
    growthSubscription = cropGrowthRef.onValue.listen((event) {
      setState(() {
        currentGrowthStage = event.snapshot.value.toString();
      });
      print("Current Growth Stage: ${event.snapshot.value.toString()}");
    });
  }

  @override
  void dispose() {
    super.dispose();
    temperatureSubscription.cancel();
    humiditySubscription.cancel();
    moistureSubscription.cancel();
    cropSubscription.cancel();
    growthSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 5, left: 10, right: 10),
        child: Column(
          children: [
            Card(
              child: widget.currentChart,
            ),
            Expanded(
              child: ListView(
                children: [
                  Card(
                    elevation: 2,
                    shadowColor: Colors.black,
                    color: Colors.greenAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Soil Moisture",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text("$currentMoisture%"),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    shadowColor: Colors.black,
                    color: Colors.greenAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Temperature",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text("$currentTemperature°C"),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    shadowColor: Colors.black,
                    color: Colors.greenAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Humidity",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text("$currentHumidity%"),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    shadowColor: Colors.black,
                    color: Colors.greenAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Crop",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(currentCrop),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    shadowColor: Colors.black,
                    color: Colors.greenAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Growth Stage",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(currentGrowthStage),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
