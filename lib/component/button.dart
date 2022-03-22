import 'package:flutter/material.dart';

class LoginSignupButton extends StatelessWidget {
  final String title;
  final dynamic ontapp;

  LoginSignupButton({required this.title, required this.ontapp});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: ontapp,
        child: Padding(
          padding: const EdgeInsets.only(
              top: 20.0, bottom: 20, right: 30, left: 30),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.black45),
        ),
      ),
    );
  }
}
