import 'package:flutter/material.dart';
import 'reminder_screen.dart'; // Import the ReminderScreen widget.

void main() => runApp(ReminderApp());

class ReminderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reminder App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ReminderScreen(), // Set ReminderScreen as the home screen.
    );
  }
}
