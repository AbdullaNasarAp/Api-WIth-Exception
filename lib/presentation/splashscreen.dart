import 'dart:async';

import 'package:flutter/material.dart';

import 'homescreen/homescreen.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Container(
                height: size.width * 0.70,
                width: size.width * 0.70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                    color: Colors.teal),
                child: Image.asset(
                  "assets/image/download3-removebg-preview.png",
                  height: size.width * 0.50,
                  width: size.width * 0.50,
                ),
              ),
            ),
            const SizedBox(
                height: 50,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballPulse,
                  colors: [Colors.teal],
                )),
          ],
        ),
      ),
    );
  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }
}
