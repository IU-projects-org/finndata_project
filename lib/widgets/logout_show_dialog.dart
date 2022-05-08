import 'package:finndata_project/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';

Future<void> logOutShowDialog(BuildContext context) async {
  await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: const Text('Exiting the application'),
            content: const Text('Are you sure you want to exit?'),
            actionsAlignment: MainAxisAlignment.spaceAround,
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Colors.black54.withOpacity(0.1))),
                  child: const Text(
                    'No',
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  )),
              TextButton(
                  key: yesButtonKey,
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();

                    context.read<AuthBloc>().add(SignOutRequested());
                  },
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Colors.black54.withOpacity(0.1))),
                  child: const Text(
                    'Yes',
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ))
            ],
          ));
}
