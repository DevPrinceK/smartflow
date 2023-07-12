// ignore_for_file: sized_box_for_whitespace

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
  String canButtonText = "Irrigate";
  String canStatus = "Not Irrigating";
  String canRemarks = "Can Irrigate";

  String cantButtonText = "Stop Irrigating";
  String cantStatus = "Irrigating";
  String cantRemarks = "Can't Irrigate";

  late FlutterGifController controller;

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
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
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
                  child: const Card(
                    color: Colors.greenAccent,
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Temperature",
                                style: TextStyle(fontSize: 16),
                              ),
                              Spacer(),
                              Text(
                                "80%",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                "Humidity",
                                style: TextStyle(fontSize: 16),
                              ),
                              Spacer(),
                              Text(
                                "70%",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                "Soil Moisture",
                                style: TextStyle(fontSize: 16),
                              ),
                              Spacer(),
                              Text(
                                "90%",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
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
                  child: const Card(
                    color: Colors.greenAccent,
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Crop",
                                style: TextStyle(fontSize: 16),
                              ),
                              Spacer(),
                              Text(
                                "Lettuce",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                "Growth Stage",
                                style: TextStyle(fontSize: 16),
                              ),
                              Spacer(),
                              Text(
                                "Stage 1",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
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
