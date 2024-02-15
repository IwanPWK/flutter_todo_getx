import 'dart:developer';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../services/notification_services.dart';
import '../services/theme_services.dart';
import 'theme.dart';
import 'widgets/button.dart';

// ignore: use_key_in_widget_constructors
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
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
      body: Column(children: [
        _addTaskBar(),
        Container(
          margin: const EdgeInsets.only(top: 20, left: 20),
          child: DatePicker(DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: primaryClr,
              selectedTextColor: Colors.white,
              dateTextStyle: GoogleFonts.lato(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey)),
              dayTextStyle: GoogleFonts.lato(textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey)),
              monthTextStyle: GoogleFonts.lato(textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey)),
              onDateChange: (date) {
            _selectedDate = date;
          }),
        )
      ]),
    );
  }

  Widget _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateFormat.yMMMMd().format(DateTime.now()), style: subHeadingStyle),
              Text("Today", style: headingStyle),
            ],
          ),
          MyButton(label: "+ Add Task", onTap: () {}),
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.colorScheme.background,
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
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage("images/avatar.jpg"),
        ),
        SizedBox(width: 20)
      ],
    );
  }
}
