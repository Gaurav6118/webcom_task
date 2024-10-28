import 'package:flutter/material.dart';
import 'package:webcom/help/route_arugument.dart';
import 'package:webcom/page/first_page/first_screen.dart';
import 'package:webcom/page/second_page/second_screen.dart';
import 'package:webcom/page/splash.dart';

// This class is using for set route
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    debugPrint(settings.name.toString());
    switch (settings.name) {
      case '/Splash':
        return MaterialPageRoute<void>(builder: (_) => const SplashPage());

      case '/FirstScreen':
        return FirstScreen.route();

      case '/SecondScreen':
        return SecondScreen.route(routeArguments: args as RouteArguments);

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute<void>(
            builder: (_) => const Scaffold(
                body: SafeArea(child: Center(child: Text('Route Error')))));
    }
  }
}
