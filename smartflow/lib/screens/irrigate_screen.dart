// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:smartflow/assets.dart';
import 'package:smartflow/screens/components/straight_nav_bar.dart';

class IrrigateScreen extends StatefulWidget {
  const IrrigateScreen({super.key});

  @override
  State<IrrigateScreen> createState() => _IrrigateScreenState();
}

class _IrrigateScreenState extends State<IrrigateScreen>
    with TickerProviderStateMixin {
  bool canIrrigate = true;
  bool irrigate = false;
  String canButtonText = "Irrigate";
  String canStatus = "Not Irrigating";
  String canRemarks = "Can Irrigate";

  String cantButtonText = "Stop Irrigating";
  String cantStatus = "Irrigating";
  String cantRemarks = "Can't Irrigate";

  // current variables
  String currentTemperature = "0";
  String currentHumidity = "0";
  String currentMoisture = "0";
  String currentCrop = '';
  String currentGrowthStage = '';

  late FlutterGifController controller;
  late StreamSubscription<dynamic> temperatureSubscription;
  late StreamSubscription<dynamic> humiditySubscription;
  late StreamSubscription<dynamic> moistureSubscription;
  late StreamSubscription<dynamic> cropSubscription;
  late StreamSubscription<dynamic> growthSubscription;
  late StreamSubscription<dynamic> irrigateSubscription;

  // StreamSubscription

  @override
  void initState() {
    super.initState();
    controller = FlutterGifController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.repeat(
        min: 0,
        max: 9,
        period: const Duration(milliseconds: 1000),
      );
    });

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

    // can irrigate reference - realtime database
    DatabaseReference irrigateRef =
        FirebaseDatabase.instance.ref().child('irrigate');
    irrigateSubscription = irrigateRef.onValue.listen((event) {
      setState(() {
        irrigate = event.snapshot.value.toString() == "true" ? true : false;
      });
      print("Irrigate: ${event.snapshot.value.toString()}");
    });
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
    // cancel all subscriptions
    temperatureSubscription.cancel();
    humiditySubscription.cancel();
    moistureSubscription.cancel();
    cropSubscription.cancel();
    growthSubscription.cancel();
    irrigateSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Irrigate"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  child: Text(
                    "Environmental Variables",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Card(
                    color: Colors.greenAccent,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Temperature",
                                style: TextStyle(fontSize: 16),
                              ),
                              const Spacer(),
                              Text(
                                "$currentTemperature°C",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Text(
                                "Humidity",
                                style: TextStyle(fontSize: 16),
                              ),
                              const Spacer(),
                              Text(
                                "$currentHumidity%",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Text(
                                "Soil Moisture",
                                style: TextStyle(fontSize: 16),
                              ),
                              const Spacer(),
                              Text(
                                "$currentMoisture%",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  child: Text(
                    "Plant Information",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Card(
                    color: Colors.greenAccent,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Crop",
                                style: TextStyle(fontSize: 16),
                              ),
                              const Spacer(),
                              Text(
                                currentCrop,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Text(
                                "Growth Stage",
                                style: TextStyle(fontSize: 16),
                              ),
                              const Spacer(),
                              Text(
                                currentGrowthStage,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  child: Text(
                    "Irrigation Status",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Card(
                    color: Colors.greenAccent,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Status",
                                style: TextStyle(fontSize: 16),
                              ),
                              const Spacer(),
                              Text(
                                canIrrigate ? canStatus : cantStatus,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Text(
                                "Remarks",
                                style: TextStyle(fontSize: 16),
                              ),
                              const Spacer(),
                              Text(
                                canIrrigate ? canRemarks : cantRemarks,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                // const Spacer(),
                SizedBox(
                    height: canIrrigate != true ? 230 : 0,
                    child: canIrrigate != true
                        ? GifImage(
                            image:
                                const AssetImage(Assets.assetsGifsIrrigating),
                            controller: controller)
                        : null),
                SizedBox(
                  height: 10,
                  child: canIrrigate != true
                      ? const LinearProgressIndicator()
                      : null,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      DatabaseReference irrigateRef =
                          FirebaseDatabase.instance.ref().child('irrigate');
                      irrigateRef.set(!irrigate);
                      setState(() {
                        canIrrigate = !canIrrigate;
                      });
                    },
                    child: Text(canIrrigate ? canButtonText : cantButtonText),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNav(selectedTab: 1),
    );
  }
}
