import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'theme.dart';
import 'widgets/button.dart';
import 'widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = DateFormat("hh:mm a").format(DateTime.now().add(const Duration(hours: 1))).toString();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = 'None';
  List<String> repeatList = ["None", "Daily"];
  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.background,
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Tasks',
                style: headingStyle,
              ),
              MyInputField(
                title: 'Title',
                hint: 'Enter Your title',
                controller: _titleController,
              ),
              MyInputField(
                title: 'Note',
                hint: 'Enter Your note',
                controller: _noteController,
              ),
              MyInputField(
                title: 'Date',
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    _getDateFromUser();
                  },
                ),
              ),
              Row(children: [
                Expanded(
                    child: MyInputField(
                  title: 'Start Time',
                  hint: _startTime,
                  widget: IconButton(
                    icon: const Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      _getTimerFromUser(isStartTime: true);
                    },
                  ),
                )),
                const SizedBox(width: 10),
                Expanded(
                  child: MyInputField(
                    title: 'End Time',
                    hint: _endTime,
                    widget: IconButton(
                      color: Colors.grey,
                      icon: const Icon(Icons.access_time_rounded),
                      onPressed: () {
                        _getTimerFromUser(isStartTime: false);
                      },
                    ),
                  ),
                )
              ]),
              MyInputField(
                title: 'Remind',
                hint: '$_selectedRemind minutes early',
                widget: DropdownButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 28,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(height: 0),
                  items: remindList
                      .map<DropdownMenuItem<String>>((int value) => DropdownMenuItem(
                            value: value.toString(),
                            child: Text('$value'),
                          ))
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedRemind = int.parse(value!);
                    });
                  },
                ),
              ),
              MyInputField(
                title: 'Repeat',
                hint: _selectedRepeat,
                widget: DropdownButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 28,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(height: 0),
                  items: repeatList
                      .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem(
                          value: value,
                          child: Text(
                            value,
                          )))
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedRepeat = value!;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _colorPalet(),
                  MyButton(
                      label: 'Create Task',
                      onTap: () {
                        _validateTask();
                      })
                ],
              ),
              const SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
    );
  }

// If a stateless widget needs context because the scope's StatelessWidget does not provide context.
  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.colorScheme.background,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
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

  _validateTask() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDb();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar('Required', 'All fields are required!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          icon: const Icon(
            Icons.warning,
            color: Colors.red,
          ),
          margin: const EdgeInsets.all(20));
    }
  }

  Column _colorPalet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: titleStyle,
        ),
        const SizedBox(
          height: 8,
        ),
        Wrap(
          children: List<Widget>.generate(
              3,
              (index) => GestureDetector(
                    onTap: () {
                      _selectedColor = index;
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: CircleAvatar(
                        radius: 13,
                        backgroundColor: index == 0
                            ? primaryClr
                            : index == 1
                                ? pinkClr
                                : yellowClr,
                        child: _selectedColor == index
                            ? const Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 14,
                              )
                            : null,
                      ),
                    ),
                  )),
        )
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2015), lastDate: DateTime(2222));

    setState(() {
      if (_pickerDate != null) {
        _selectedDate = _pickerDate;
      }
    });
  }

  _getTimerFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String? _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Time cancled");
    } else if (isStartTime == true) {
      _startTime = _formatedTime!;
    } else if (isStartTime == false) {
      _endTime = _formatedTime!;
    }
    setState(() {});
  }

  _showTimePicker() {
    log('cek nilai $_startTime');
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(':')[0]),
        minute: int.parse(_startTime.split(':')[1].split(' ')[0]),
      ),
    );
  }

  void _addTaskToDb() async {
    // int val = await _taskController.addTask(
    //     task: Task(
    //         note: _noteController.text,
    //         title: _titleController.text,
    //         date: DateFormat.yMd().format(_selectedDate),
    //         startTime: _startTime,
    //         endTime: _endTime,
    //         remiind: _selectedRemind,
    //         repeat: _selectedRepeat,
    //         color: _selectedColor,
    //         isCompleted: 0));
    // print('My id is $val');
  }
}
