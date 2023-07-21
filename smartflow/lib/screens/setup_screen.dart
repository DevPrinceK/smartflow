import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smartflow/screens/components/straight_nav_bar.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  String currentCrop = 'Select Crop...';
  String currentGrowthStage = 'Select Stage...';
  late StreamSubscription<dynamic> cropSubscription;
  late StreamSubscription<dynamic> growthSubscription;

  @override
  initState() {
    super.initState();

    // crop reference - realtime database
    DatabaseReference cropRef = FirebaseDatabase.instance.ref().child('crop');
    cropSubscription = cropRef.onValue.listen((event) {
      setState(() {
        currentCrop = event.snapshot.value.toString();
      });
      print("Current Crop: ${event.snapshot.value.toString()}");
    });

    // crop growth reference - realtime database
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Setup"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: MyCustomForm(
          crop: currentCrop,
          stage: currentGrowthStage,
        ),
      ),
      bottomNavigationBar: CustomBottomNav(selectedTab: 2),
    );
  }
}

// ignore: must_be_immutable
class MyCustomForm extends StatefulWidget {
  String crop;
  String stage;

  MyCustomForm({
    super.key,
    required this.crop,
    required this.stage,
  });

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          const Center(child: Text("System Setup")),
          const SizedBox(height: 20),
          DropdownButtonFormField(
            value: widget.crop,
            decoration: const InputDecoration(
              labelText: 'Crop',
            ),
            items: const <String>[
              'Select Crop...',
              'Lettuce',
              'Cabbage',
              'Carrot',
              'Tomatoes',
              'Pepper',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                widget.crop = newValue!;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty || value == "Select Crop...") {
                return 'This field is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField(
            value: widget.stage,
            decoration: const InputDecoration(
              labelText: 'Growth Stage',
            ),
            items: const <String>[
              'Select Stage...',
              'Stage 1 (1-2 months)',
              'Stage 2 (2-3 months)',
              'Stage 3 (3-4 months)',
              'Stage 4 (4-5 months)',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                widget.stage = newValue!;
              });
            },
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  value == "Select Stage...") {
                return 'This field is required';
              }
              return null;
            },
          ),
          const Spacer(),
          // ignore: sized_box_for_whitespace
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Center(child: Text('Processing Data'))),
                  );

                  // update crop and growth stage in realtime database
                  DatabaseReference cropRef =
                      FirebaseDatabase.instance.ref().child('crop');
                  cropRef.set(widget.crop);

                  DatabaseReference growthRef =
                      FirebaseDatabase.instance.ref().child('stage');
                  growthRef.set(widget.stage);

                  // snackbar notification
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Center(child: Text('Data Saved!'))),
                  );
                }
              },
              child: const Text("Save"),
            ),
          )
        ],
      ),
    );
  }
}
