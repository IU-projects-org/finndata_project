import 'package:flutter/material.dart';

class LoginSignupButton extends StatelessWidget {
  final String title;
  final dynamic ontapp;

  const LoginSignupButton({Key? key, required this.title, this.ontapp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: ontapp,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20.0, bottom: 20, right: 30, left: 30),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.black38),
          foregroundColor: MaterialStateProperty.all(Colors.white),
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
