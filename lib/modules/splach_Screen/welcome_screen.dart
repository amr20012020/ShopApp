import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/SessionManagment.dart';
import 'package:shop_app/modules/onBoarding/on_boarding_screen.dart';
import 'package:shop_app/routes/routes_names.dart';
import 'package:shop_app/utils/size_config.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    Timer(Duration(seconds: 1), () {
      _animationController.forward();
      Timer(Duration(seconds: 2), () {
        if (SessionManagement.isGuest || SessionManagement.isUser) {
          Get.offNamed(AppRoutesNames.bottomBarScreen);
        } else {
          Get.offNamed(AppRoutesNames.onBoardingScreen);
        }
      });
    });
  }



  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: /*AnimatedSplashScreen(
        splash: Column(
          children: [
            Image.asset(
              'assets/images/logo2141.png',
              height: 35 * imageSizeMultiplier,
            ),
            SizedBox(
              height: 20.0,
            ),
            const Text(
              "Welcome To ESCB App",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
            ),
          ],
        ),
        nextScreen: OnBoardingScreen(),
        splashIconSize: 250,
        duration: 4000,
        splashTransition: SplashTransition.rotationTransition,
      ),*/
      FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo2141.png',
                height: 35 * imageSizeMultiplier,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Welcome To ESCB App",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
