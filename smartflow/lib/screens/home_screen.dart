import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SmartFlow"),
        centerTitle: true,
        elevation: 0,
      ),
      body: const Center(
        child: Text('TAB BAR VIEW'),
      ),
    );
  }
}
