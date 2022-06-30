import 'package:food_truck/screens/login_screen.dart';
import 'package:food_truck/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:food_truck/components/rounded_button.dart';
import 'package:location/location.dart';
import 'package:food_truck/components/sound_effects.dart' as sounds;

/// Used for ensuring the user allows location permissions
/// to the app so the map screen will function properly and be centered
/// on the user's location on startup.
Location location = Location.instance;

/// A route for the FoodTruck app. It is a simple home screen for the app
/// with a logo, animated text, and login and register buttons.
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String id = 'welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  /// Checks if the user has already given permission to the app.
  /// If the user did not give permission, then simply request for
  /// permission once.
  void requestLocationPermission() async {
    if (await location.hasPermission() != PermissionStatus.granted) {
      await location.requestPermission();
    }
  }

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animation =
        ColorTween(begin: Colors.red, end: Colors.black).animate(controller);
    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 60.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    ColorizeAnimatedText(
                      'Fork Knife',
                      textAlign: TextAlign.center,
                      colors: [
                        Colors.white,
                        Colors.red,
                        Colors.yellow,
                        Colors.redAccent
                      ],
                      textStyle: const TextStyle(
                        fontFamily: 'FugazOne',
                        color: Colors.white,
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    ColorizeAnimatedText(
                      "It's Truckin' Time",
                      textAlign: TextAlign.center,
                      colors: [
                        Colors.white,
                        Colors.red,
                        Colors.yellow,
                        Colors.redAccent
                      ],
                      textStyle: const TextStyle(
                        fontFamily: 'FugazOne',
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Login',
              colour: Colors.red,
              onPressed: () {
                sounds.playClick();
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              title: 'Register',
              colour: Colors.redAccent,
              onPressed: () {
                sounds.playClick();
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
