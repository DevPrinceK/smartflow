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
  final List<TemperatureData> temperatureData = [
    TemperatureData(date: '01/01/2023', temperature: 25),
    TemperatureData(date: '01/02/2023', temperature: 27),
    TemperatureData(date: '01/03/2023', temperature: 22),
    TemperatureData(date: '01/04/2023', temperature: 29),
    TemperatureData(date: '01/05/2023', temperature: 30),
    TemperatureData(date: '01/06/2023', temperature: 23),
    // Add more temperature data here...
  ];

  final List<MoistureData> moistureData = [
    MoistureData(location: 'Location 1', moistureLevel: 50),
    MoistureData(location: 'Location 2', moistureLevel: 70),
    MoistureData(location: 'Location 3', moistureLevel: 60),
    MoistureData(location: 'Location 4', moistureLevel: 50),
    MoistureData(location: 'Location 5', moistureLevel: 70),
    MoistureData(location: 'Location 6', moistureLevel: 60),
    // Add more soil moisture data here...
  ];

  final List<HumidityData> humidityData = [
    HumidityData(label: 'Humidity 1', humidity: 75),
    HumidityData(label: 'Humidity 2', humidity: 85),
    HumidityData(label: 'Humidity 3', humidity: 72),
    HumidityData(label: 'Humidity 4', humidity: 79),
    HumidityData(label: 'Humidity 5', humidity: 80),
    HumidityData(label: 'Humidity 6', humidity: 70),
  ];

  final List<AllData> allData = [
    AllData(label: 'Moisture', val: 75),
    AllData(label: 'Humidity', val: 85),
    AllData(label: 'Temperature', val: 72),
  ];

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
            GeneralTab(currentChart: MoistureChart(moistureData: moistureData)),
            GeneralTab(
                currentChart:
                    TemperatureChart(temperatureData: temperatureData)),
            GeneralTab(currentChart: HumidityChart(humidityData: humidityData)),
          ],
        ),
        bottomNavigationBar: CustomBottomNav(selectedTab: 0),
      ),
    );
  }
}
