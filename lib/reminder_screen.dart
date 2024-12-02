import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReminderScreen extends StatefulWidget {
  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  List<Map<String, dynamic>> reminders = [
    {'text': 'Task 1', 'dueDate': 'Wednesday, Dec 5', 'completed': false},
    {'text': 'Task 2', 'dueDate': 'Wednesday, Dec 5', 'completed': false},
    {'text': 'Task 3', 'dueDate': 'Wednesday, Dec 5', 'completed': false},
    {'text': 'Task 5', 'dueDate': 'Wednesday, Dec 5', 'completed': false},
  ];

  void _addReminder() {
    setState(() {
      reminders.add({
        'text': 'New Task',
        'dueDate': 'Thursday, Dec 7',
        'completed': false,
      });
    });
  }

  void _toggleCompletion(int index) {
    setState(() {
      reminders[index]['completed'] = !reminders[index]['completed'];
    });
  }

  void _deleteReminder(int index) {
    setState(() {
      reminders.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('EEEE, MMM d').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text('My Reminders'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Container(
          padding: EdgeInsets.only(top: 50, left: 16),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Icon(Icons.calendar_today, color: Colors.red),
              SizedBox(width: 8),
              Text(
                'Monday, Dec 2',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Search bar and title
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.task, size: 28),
                    SizedBox(width: 8),
                    Text(
                      'MY REMINDERS',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'SEARCH',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                final reminder = reminders[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reminder['text'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Due: ${reminder['dueDate']}',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                // Add edit functionality here
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                reminder['completed']
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color: Colors.green,
                              ),
                              onPressed: () => _toggleCompletion(index),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteReminder(index),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addReminder,
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
        tooltip: 'Add Reminder',
      ),
    );
  }
}
