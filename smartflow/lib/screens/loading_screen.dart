import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:smartflow/navigation/config.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      GoRouter.of(context).pushReplacementNamed(RouteNames.home);
    });
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
        // backgroundColor: Colors.green,
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              ColorizeAnimatedText(
                'SmartFlow',
                textStyle: colorizeTextStyle,
                colors: colorizeColors,
                speed: const Duration(milliseconds: 400),
              ),
            ],
            isRepeatingAnimation: true,
            onTap: () {},
          ),
        ),
        Center(
            child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'The IoT-Based Smart Irrigation System',
              textStyle: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
              speed: const Duration(milliseconds: 50),
            ),
          ],
          totalRepeatCount: 4,
          pause: const Duration(milliseconds: 1000),
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
        )),
      ],
    ));
  }
}
