import 'package:flutter/material.dart';
import 'package:prefs/prefs.dart';
import 'package:solu_bloc/config.dart';
import 'package:solu_bloc/ui/screens/couter_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Prefs.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: config.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CounterScreen(title: 'Flutter Demo Home Page'),
    );
  }
}
