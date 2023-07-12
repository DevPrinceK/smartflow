import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:go_router/go_router.dart';
import 'package:smartflow/assets.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:smartflow/navigation/config.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  late FlutterGifController controller;

  @override
  void initState() {
    super.initState();
    controller = FlutterGifController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.repeat(
        min: 0,
        max: 53,
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
    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 40.0,
      fontFamily: 'Horizon',
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GifImage(
            image: const AssetImage(Assets.assetsGifsTaco),
            // image: const AssetImage(Assets.assetsGifsTomatoes),
            controller: controller,
          ),
          const SizedBox(height: 20),
          Center(
            child: AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  'SmartFlow',
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                ),
              ],
              isRepeatingAnimation: true,
              onTap: () {
                // print("Tap Event");
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              child: const Text('Home'),
              onPressed: () {
                GoRouter.of(context).pushReplacementNamed(RouteNames.home);
              },
            ),
          )
        ],
      ),
    );
  }
}
