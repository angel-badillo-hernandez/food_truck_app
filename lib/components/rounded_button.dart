import 'package:flutter/material.dart';

/// A simple styled, round button for use in the FoodTruck app.
/// It will serve as login / register buttons.
class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.title,
    required this.colour,
    required this.onPressed,
  }) : super(key: key);
  final Color colour;
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'FugazOne',
            ),
          ),
        ),
      ),
    );
  }
}
