import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:myoxigin/Screens/auth/auth_checker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 6), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const AuthChecker()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('ffffff'),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Spacer(),
          Center(
            child: Image.asset(
              'image/log.png',
              height: 78,
              width: 52,
            ),
          ),
          const Spacer(),
          LinearPercentIndicator(
            padding: const EdgeInsets.all(0),
            width: MediaQuery.of(context).size.width,
            animation: true,
            lineHeight: 10.0,
            animationDuration: 4000,
            percent: 1,
            barRadius: Radius.zero,
            progressColor: const Color.fromRGBO(0, 0, 0, 1),
          ),
        ]),
      ),
    );
  }
}
