import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screen/home_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            Image.asset(
              "assets/images/splash_pic.jpg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: height * .6,
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Text(
              "Top headlines",
              style: GoogleFonts.acme(
                letterSpacing: .4,
                fontSize: 40,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            SpinKitCircle(
              color: Colors.black,
              size: 80,
            )
          ],
        ),
      ),
    );
  }
}
