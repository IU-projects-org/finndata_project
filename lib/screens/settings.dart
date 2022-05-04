import 'package:flutter/material.dart';

import '../widgets/logout_show_dialog.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
      height: 400,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Modal BottomSheet'),
            // const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.black),
              child: const Text('Logout'),
              onPressed: () async {
                await logOutShowDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
