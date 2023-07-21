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
  // subscriptions
  late StreamSubscription<DatabaseEvent> temperatureSubscription;
  late StreamSubscription<DatabaseEvent> humiditySubscription;
  late StreamSubscription<DatabaseEvent> moistureSubscription;
  late StreamSubscription<DatabaseEvent> cropSubscription;
  late StreamSubscription<DatabaseEvent> growthSubscription;

  @override
  void initState() {
    super.initState();

    // temperature reference - realtime database
    DatabaseReference tempRef =
        FirebaseDatabase.instance.ref().child('temperature');
    temperatureSubscription = tempRef.onValue.listen((event) {
      setState(() {
        currentTemperature = event.snapshot.value.toString();
      });
      print("Current Temperature: ${event.snapshot.value.toString()}");
    });

    // humidity reference - realtime database
    DatabaseReference humRef =
        FirebaseDatabase.instance.ref().child('humidity');
    humiditySubscription = humRef.onValue.listen((event) {
      setState(() {
        currentHumidity = event.snapshot.value.toString();
      });
      print("Current Humidity: ${event.snapshot.value.toString()}");
    });

    // soil moisture reference - realtime database
    DatabaseReference moistRef =
        FirebaseDatabase.instance.ref().child('moisture');
    moistureSubscription = moistRef.onValue.listen((event) {
      setState(() {
        currentMoisture = event.snapshot.value.toString();
      });
      print("Current Moisture: ${event.snapshot.value.toString()}");
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
