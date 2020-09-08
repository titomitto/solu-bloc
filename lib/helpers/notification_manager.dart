import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:solu_bloc/api/api.dart';

import '../tools/manager.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationManager extends Manager {
  static NotificationManager instance;
  factory NotificationManager() => instance ??= NotificationManager._instance();
  NotificationManager._instance();

  Future<void> showRecordsSyncingNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'sat_notification', 'syncing records', 'Syncing of records started',
        importance: Importance.Max,
        priority: Priority.High,
        showProgress: true,
        indeterminate: true
        // timeoutAfter: 5000,
        );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, 'Syncing records',
        'Your records are currently being synced', platformChannelSpecifics);
  }

  Future<void> showRecordsSyncedNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'sat_notification',
      'synced records',
      'Records synced successfully',
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, 'Synced all records',
        'All records have been synced', platformChannelSpecifics);
  }

  Future<void> showVisitReminderNotification(
      String title, String bodyText) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'sat_notification',
      'visit reminder',
      'Visit Reminder',
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        2, title, bodyText, platformChannelSpecifics);
  }

  Future<void> showRecordsSyncFailedNotification(details) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'sat_notification',
      'synced records',
      'Some records were not synced',
      importance: Importance.Max,
      priority: Priority.High,
      color: const Color.fromARGB(255, 255, 0, 0),
      //timeoutAfter: 5000,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Syncing incomplete',
      'Some records failed to sync',
      platformChannelSpecifics,
    );
  }

  @override
  Future init() async {
    // TODO: implement init
    super.init();
    NotificationAppLaunchDetails notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    // Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
    // of the `IOSFlutterLocalNotificationsPlugin` class
    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      if (payload != null) {
        debugPrint('notification payload: ' + payload);
      }
    });
  }
}

var notificationManager = NotificationManager();
