import 'package:flutter/material.dart';
import 'package:news_app/utils/routes/routes_name.dart';
import 'package:news_app/utils/routes/routes_services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RoutesName.splashScreen,
      onGenerateRoute: RoutesServices.generateRoute,
      debugShowCheckedModeBanner: false,
      title: "News App",
      theme: ThemeData(
        appBarTheme: AppBarTheme(),
        scaffoldBackgroundColor: Colors.grey.shade100,
      ),
    );
  }
}
