import 'package:finndata_project/screens/settings.dart';
import 'package:flutter/material.dart';

Future<void> showSettingsBottomDialog(BuildContext context) async {
  await showModalBottomSheet<void>(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    context: context,
    builder: (BuildContext context) {
      return const Settings();
    },
  );
}
