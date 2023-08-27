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
  Map<dynamic, dynamic> data = {};
  // subscriptions
  late StreamSubscription<dynamic> dataSubscription;
  // all data - temp, humidity, moisture
  final List<AllData> allData = [
    AllData(label: 'Moisture', val: 50),
    AllData(label: 'Humidity', val: 85),
    AllData(label: 'Temperature', val: 72),
  ];

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

      // Find the 'Temperature' object in allData and update its value
      int temperatureIndex =
          allData.indexWhere((data) => data.label == 'Temperature');
      int humidityIndex =
          allData.indexWhere((data) => data.label == 'Humidity');
      int moistureIndex =
          allData.indexWhere((data) => data.label == 'Moisture');
      setState(() {
        allData[temperatureIndex] =
            AllData(label: 'Temperature', val: temps[0].toDouble());
        allData[humidityIndex] =
            AllData(label: 'Humidity', val: hum[0].toDouble());
        allData[moistureIndex] =
            AllData(label: 'Moisture', val: moist[0].toDouble());
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    dataSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SafeArea(
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
      ),
    );
  }
}
