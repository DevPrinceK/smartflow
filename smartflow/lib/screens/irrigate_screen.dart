import 'package:flutter/material.dart';

class IrrigateScreen extends StatefulWidget {
  const IrrigateScreen({super.key});

  @override
  State<IrrigateScreen> createState() => _IrrigateScreenState();
}

class _IrrigateScreenState extends State<IrrigateScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('IRRIGATE SCREEN'),
      ),
    );
  }
}
