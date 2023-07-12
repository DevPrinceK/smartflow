import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 5, left: 10, right: 10),
        child: Column(
          children: [
            Card(
              // color: Colors.green,
              child: widget.currentChart,
            ),
            Expanded(
              child: ListView(
                children: const [
                  Card(
                    elevation: 2,
                    shadowColor: Colors.black,
                    color: Colors.greenAccent,
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Soil Moisture",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text("86%"),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    shadowColor: Colors.black,
                    color: Colors.greenAccent,
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Temperature",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text("75%"),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    shadowColor: Colors.black,
                    color: Colors.greenAccent,
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Humidity",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text("58%"),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    shadowColor: Colors.black,
                    color: Colors.greenAccent,
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Crop",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text("Lettuce"),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    shadowColor: Colors.black,
                    color: Colors.greenAccent,
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Growth Stage",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text("Stage 1"),
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
