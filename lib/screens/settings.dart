import 'package:finndata_project/constants/app_constants.dart';
import 'package:finndata_project/utils/local_storage_service.dart';
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
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Settings'),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ListTile(
                    leading: Radio<String>(
                      value: 'Light',
                      activeColor: Colors.black,
                      groupValue: appSettings.theme ? 'Light' : 'Dark',
                      onChanged: (value) {
                        setState(() {
                          appSettings.theme = value == 'Light';
                        });
                        SettingsStorage().update();
                      },
                    ),
                    title: const Text('Light'),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    leading: Radio<String>(
                      activeColor: Colors.black,
                      value: 'Dark',
                      groupValue: appSettings.theme ? 'Light' : 'Dark',
                      onChanged: (value) {
                        setState(() {
                          appSettings.theme = value == 'Light';
                        });
                        SettingsStorage().update();
                      },
                    ),
                    title: const Text('Dark'),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Language: '),
                DropdownButton<String>(
                  value: appSettings.language,
                  onChanged: (String? newValue) {
                    setState(() {
                      appSettings.language = newValue!;
                    });
                    SettingsStorage().update();
                  },
                  items: <String>['English', 'German', 'Russian']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(),
            const SizedBox(),
            const SizedBox(),
            const SizedBox(),
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
