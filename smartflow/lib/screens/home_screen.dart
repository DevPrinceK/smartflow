// ignore_for_file: avoid_print

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smartflow/screens/charts/all_charts.dart';
import 'package:smartflow/screens/charts/humidity_chart.dart';
import 'package:smartflow/screens/charts/moisture_chart.dart';
import 'package:smartflow/screens/charts/temperature_chart.dart';
import 'package:smartflow/screens/components/straight_nav_bar.dart';
import 'package:smartflow/screens/tabs/general_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // current variables
  String currentTemperature = "0";
  String currentHumidity = "0";
  String currentMoisture = "0";
  // subscriptions
  late StreamSubscription<dynamic> temperatureSubscription;
  late StreamSubscription<dynamic> humiditySubscription;
  late StreamSubscription<dynamic> moistureSubscription;
  // all data - temp, humidity, moisture
  final List<AllData> allData = [
    AllData(label: 'Moisture', val: 50),
    AllData(label: 'Humidity', val: 85),
    AllData(label: 'Temperature', val: 72),
  ];

  @override
  void initState() {
    super.initState();

    // temperature reference - realtime database
    DatabaseReference tempRef =
        FirebaseDatabase.instance.ref().child('temperature');
    temperatureSubscription = tempRef.onValue.listen((event) {
      setState(() {
        currentTemperature = event.snapshot.value.toString();
        // Find the 'Temperature' object in allData and update its value
        int temperatureIndex =
            allData.indexWhere((data) => data.label == 'Temperature');
        if (temperatureIndex != -1) {
          allData[temperatureIndex] = AllData(
              label: 'Temperature', val: double.parse(currentTemperature));
        }
      });
      print("Current Temperature: ${event.snapshot.value.toString()}");
    });

    // humidity reference - realtime database
    DatabaseReference humRef =
        FirebaseDatabase.instance.ref().child('humidity');
    humiditySubscription = humRef.onValue.listen((event) {
      setState(() {
        currentHumidity = event.snapshot.value.toString();
        // Find the 'Humidity' object in allData and update its value
        int humidityIndex =
            allData.indexWhere((data) => data.label == 'Humidity');
        if (humidityIndex != -1) {
          allData[humidityIndex] =
              AllData(label: 'Humidity', val: double.parse(currentHumidity));
        }
      });
      print("Current Humidity: ${event.snapshot.value.toString()}");
    });

    // soil moisture reference - realtime database
    DatabaseReference moistRef =
        FirebaseDatabase.instance.ref().child('moisture');
    moistureSubscription = moistRef.onValue.listen((event) {
      setState(() {
        currentMoisture = event.snapshot.value.toString();
        // Find the 'Moisture' object in allData and update its value
        int moistureIndex =
            allData.indexWhere((data) => data.label == 'Moisture');
        if (moistureIndex != -1) {
          allData[moistureIndex] =
              AllData(label: 'Moisture', val: double.parse(currentMoisture));
        }
      });
      print("Current Moisture: ${event.snapshot.value.toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.greenAccent,
        appBar: AppBar(
          title: const Text("SmartFlow"),
          centerTitle: true,
          elevation: 0,
          bottom: const TabBar(
            unselectedLabelColor: Colors.black,
            labelColor: Colors.greenAccent,
            indicatorColor: Colors.lightGreenAccent,
            isScrollable: true,
            tabs: [
              Tab(text: 'ALL'),
              Tab(text: 'MOISTURE'),
              Tab(text: 'TEMPERATURE'),
              Tab(text: 'HUMIDITY'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GeneralTab(currentChart: AllCharts(allData: allData)),
            const GeneralTab(currentChart: MoistureChart()),
            const GeneralTab(currentChart: TemperatureChart()),
            const GeneralTab(currentChart: HumidityChart()),
          ],
        ),
        bottomNavigationBar: CustomBottomNav(selectedTab: 0),
      ),
    );
  }
}
