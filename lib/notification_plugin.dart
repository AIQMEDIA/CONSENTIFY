import 'package:flutter/material.dart';
import 'dart:io' show File, Platform;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationPlugin {
  FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin;
  final BehaviorSubject<ReceivedNotification>
      didReceivedLocalNotificationSubject =
      BehaviorSubject<ReceivedNotification>();
  var initializationSettings;

  NotificationPlugin._() {
    init();
  }

  init() async {
    flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      _requestIOSPermission();
    }
    initializePlatformSpecifics();
  }

  initializePlatformSpecifics() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_notf_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: (id, title, body, payload) async {
          ReceivedNotification receivedNotification = ReceivedNotification(
              id: id, title: title, body: body, payload: payload);
          didReceivedLocalNotificationSubject.add(receivedNotification);
        });

    initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    // flutterLocalNotificationPlugin.initialize(initializationSettings,
    //     onSelectNotification: (String payload) {
    //   //
    // });
  }

  _requestIOSPermission() {
    flutterLocalNotificationPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        .requestPermissions(alert: false, badge: true, sound: true);
  }

  setListenerForLowerVersions(Function onNotificationInLowerVersions) {
    didReceivedLocalNotificationSubject.listen((receivedNotification) {
      onNotificationInLowerVersions(receivedNotification);
    });
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationPlugin.initialize(initializationSettings,
        // ignore: missing_return
        onSelectNotification: (String payload) async {
      onNotificationClick(payload);
    });
  }

  Future<void> scheduleNotification() async {
    var scheduleNotificationDateTime = DateTime.now().add(Duration(hours: 4));
    var androidChannelSpecifics = AndroidNotificationDetails(
        'channelId', 'channelName', 'channelDescription',
        importance: Importance.Max,
        priority: Priority.High,
        playSound: true,
        styleInformation: DefaultStyleInformation(true, true));

    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
        NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
    await flutterLocalNotificationPlugin.schedule(
        0,
        'Review Agreement',
        'Are you satisfied with the agreement you created ?',
        scheduleNotificationDateTime,
        platformChannelSpecifics,
        payload: 'Test Payload');
  }
}

NotificationPlugin notificationPlugin = NotificationPlugin._();

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification(
      {@required this.id,
      @required this.title,
      @required this.body,
      @required this.payload});
}
