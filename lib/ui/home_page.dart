import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/notification_services.dart';
import '../services/theme_services.dart';

// ignore: use_key_in_widget_constructors
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NotifyHelper notifyHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: const Text('Theme Data'),
    );
  }

  _appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          //membuat instance dari class tanpa membuat method static
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
            title: "Theme Changed",
            body: Get.isDarkMode ? "Activated Light Theme" : "Activated Dark Theme",
          );
          notifyHelper.scheduledNotification();
          // NotifyHelper.showSimpleNotification(title: "Theme is changed", body: "This is a simple notification", payload: "This is a simple data");
          log('cek 123');
        },
        child: const Icon(
          Icons.nightlight_round,
          size: 20,
        ),
      ),
      actions: const [
        Icon(
          Icons.person,
          size: 20,
        ),
        SizedBox(width: 20)
      ],
    );
  }
}
