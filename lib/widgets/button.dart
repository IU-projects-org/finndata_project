import 'package:flutter/material.dart';

class LoginSignupButton extends StatelessWidget {
  const LoginSignupButton({Key? key, required this.title, this.ontap})
      : super(key: key);
  final String title;
  final dynamic ontap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: ontap,
        style: Theme.of(context).elevatedButtonTheme.style,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, right: 30, left: 30),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
