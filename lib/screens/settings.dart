import 'dart:convert';

import 'package:finndata_project/constants/app_constants.dart';
import 'package:finndata_project/utils/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Localization/app_localizations.dart';
import '../bloc/local/locale_cubit.dart';
import '../widgets/logout_show_dialog.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final labels = jsonDecode(
        jsonEncode(AppLocalizations.of(context)!.translate('settings_screen')));
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
      height: 400,
      child: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              labels['title'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
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
                          myTheme.switchTheme();
                        });
                        SettingsStorage().update();
                      },
                    ),
                    title: Text(labels['theme_mode'][0]),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    leading: Radio<String>(
                      value: 'Dark',
                      activeColor: Colors.black,
                      groupValue: appSettings.theme ? 'Light' : 'Dark',
                      onChanged: (value) {
                        setState(() {
                          myTheme.switchTheme();
                        });
                        SettingsStorage().update();
                      },
                    ),
                    title: Text(labels['theme_mode'][1]),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${labels['language_label']}: ',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                DropdownButton<String>(
                  value: appSettings.language,
                  onChanged: (String? newValue) {
                    setState(() {
                      appSettings.language = newValue!;
                    });
                    if (newValue == 'Russian') {
                      BlocProvider.of<LocaleCubit>(context).toRussian();
                    } else {
                      BlocProvider.of<LocaleCubit>(context).toEnglish();
                    }

                    SettingsStorage().update();
                  },
                  items: <String>['English', 'Russian']
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
              key: logoutButtonKey,
              style: Theme.of(context).elevatedButtonTheme.style,
              child: Text(labels['logout_button']),
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
