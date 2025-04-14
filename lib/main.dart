import 'package:flutter/material.dart';
import 'package:news_app/screen/splash_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "News App",
      theme: ThemeData(
        appBarTheme: AppBarTheme(),
        scaffoldBackgroundColor: Colors.grey.shade100,
      ),
      home: SplashScreen(),
    );
  }
}
