import 'package:flutter/material.dart';
import 'package:food_truck/screens/welcome_screen.dart';
import 'package:food_truck/screens/login_screen.dart';
import 'package:food_truck/screens/registration_screen.dart';
import 'package:food_truck/screens/map_screen.dart';

/// Essentially, builds and runs the app
void main() => runApp(const FoodTruck());

/// The FoodTruck class is the root of the widget tree for this app,
/// it contains the MaterialApp widget with defined routes,
/// the welcome screen, login screen, registration screen,
/// and the map screen.
class FoodTruck extends StatelessWidget {
  const FoodTruck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        MapScreen.id: (context) => const MapScreen(),
      },
    );
  }
}
