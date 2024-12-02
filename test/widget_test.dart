import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Reminder App Widget Test', (WidgetTester tester) async {
    // Define the app structure
    final app = MaterialApp(
      home: ReminderScreen(),
    );

    // Pump the widget into the test environment
    await tester.pumpWidget(app);

    // 1. Verify the initial state of the reminders
    expect(find.text('Buy groceries'), findsOneWidget);
    expect(find.text('Call mom'), findsOneWidget);
    expect(find.text('Finish Flutter project'), findsOneWidget);

    // 2. Check the Floating Action Button adds a new reminder
    final fab = find.byType(FloatingActionButton);
    expect(fab, findsOneWidget);

    // Tap the FAB to add a new reminder
    await tester.tap(fab);
    await tester.pump(); // Rebuild the widget after the state change

    // Verify that a new reminder is added
    expect(find.text('New Reminder'), findsOneWidget);

    // 3. Test the checkbox interaction
    final checkbox = find.byType(Checkbox).first; // Find the first checkbox
    expect(tester.widget<Checkbox>(checkbox).value, false); // Initially unchecked

    // Tap the checkbox to mark it as completed
    await tester.tap(checkbox);
    await tester.pump(); // Rebuild the widget after the state change

    // Verify the checkbox is now checked
    expect(tester.widget<Checkbox>(checkbox).value, true);
  });
}

// Dummy ReminderScreen for testing
class ReminderScreen extends StatefulWidget {
  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  List<Map<String, dynamic>> reminders = [
    {'text': 'Buy groceries', 'completed': false},
    {'text': 'Call mom', 'completed': false},
    {'text': 'Finish Flutter project', 'completed': false},
  ];

  void _addReminder() {
    setState(() {
      reminders.add({'text': 'New Reminder', 'completed': false});
    });
  }

  void _toggleCompletion(int index) {
    setState(() {
      reminders[index]['completed'] = !reminders[index]['completed'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Reminders'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: reminders.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Checkbox(
              value: reminders[index]['completed'],
              onChanged: (_) => _toggleCompletion(index),
            ),
            title: Text(
              reminders[index]['text'],
              style: TextStyle(
                decoration: reminders[index]['completed']
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addReminder,
        child: Icon(Icons.add),
        tooltip: 'Add Reminder',
      ),
    );
  }
}
