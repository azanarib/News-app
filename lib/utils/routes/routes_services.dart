import 'package:flutter/material.dart';
import 'package:news_app/screen/categories_screen.dart';
import 'package:news_app/screen/home_Screen.dart';
import 'package:news_app/screen/news_details_screen.dart';
import 'package:news_app/screen/splash_Screen.dart';
import 'package:news_app/utils/routes/routes_name.dart';

class RoutesServices {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case RoutesName.categoriesScreen:
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      case RoutesName.detailsScreen:
        return MaterialPageRoute(
            builder: (context) => NewsDetailScreen(
                  data: settings.arguments as Map<dynamic, dynamic>,
                ));
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: Center(
                    child:
                        Text("No routes found for ${settings.name.toString()}"),
                  ),
                ));
    }
  }
}
