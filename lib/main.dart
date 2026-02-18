import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_02/add/add_todo_page.dart';
import 'package:todo_list_02/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  // This widget is the root of your application.
  bool isDarkTheme = false;
  bool isOnboardShown = false;
  late SharedPreferences preferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initPreferences();
  }

  @override
  Widget build(BuildContext context) {
     print("myApp: $isDarkTheme");
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      home: isDarkTheme ? const MyHomePage(title: 'Flutter Demo Home Page') : const AddTodoPage(),
    );
  }

  void _initPreferences() async {
    preferences = await SharedPreferences.getInstance();
    final savedTheme = preferences.getBool('isDarkTheme') ?? false;

    setState(() {
      isDarkTheme = savedTheme;
    });

    print("myApp: $isDarkTheme");
  }
}

