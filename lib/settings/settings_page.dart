
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  late bool value;
  late SharedPreferences preferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    value = false;
    _initPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Настройки"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Text("Темная тема"),
              Spacer(),
              Switch(
                value: value, 
                onChanged: (v) {
                  setState(() => value = v);
                  print(value);
                  _setPreferences();
                }
                )
            ],
          )
        ]
      ),
    );
  }

  void _initPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  void _setPreferences() async {
    preferences.setBool('isDarkTheme', value);
    preferences.setString('user', "Nursultan");
    preferences.setInt('code', 10);
  }

}