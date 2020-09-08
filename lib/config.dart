import 'dart:async';
import 'package:flutter/material.dart';

class Config {
  static Config instance;
  factory Config() => instance ??= Config._instance();
  Config._instance();
  StreamController<dynamic> _controller = StreamController<dynamic>.broadcast();
  Stream<dynamic> get stream => _controller.stream;

  String appName = "Counter Todo";
  String apiUrl = "https://jsonplaceholder.typicode.com";
  String appVersion = "1.0.0";
  String appDatabase = "sample";
  String appIcon = "assets/images/icon.png";
  String appDescription = "A sample app for todo";
  String serverIp = "1.0.0.1";
  Color contrastColor = Colors.white;
  ThemeData themeData = ThemeData(
    primaryColor: Colors.blue,
    accentColor: Colors.orangeAccent,
  );
}

var config = Config();
