import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:weather/weather.dart';
import 'package:oni/pages/pages.Home.dart';

class PeriodicWeatherCheck{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  void init(){
    print("notification init");
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid = AndroidInitializationSettings("app_icon");
    var initSettings = InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  void pushNotification(String title, String text) async{
    if(flutterLocalNotificationsPlugin == null) init();
    var android = AndroidNotificationDetails(
        'oni_notification_test', 'oni_notification_test_channel ', 'oni_notification_test_desc',
        priority: Priority.defaultPriority, importance: Importance.defaultImportance);
    var platform = new NotificationDetails(android: android);
    await flutterLocalNotificationsPlugin.show(
        0, title, text, platform);
  }
  void checkWeather(notificationEnabled) async{
    // THIS IS A DUMMY FUNCTION
    print("checkWeather called");
    pushNotification("It's heavy raining outside", "You better get a diving suit right now");
  }
}