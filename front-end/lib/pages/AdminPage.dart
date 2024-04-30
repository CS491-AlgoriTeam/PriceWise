import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'dart:io';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: bodyController,
              decoration: InputDecoration(labelText: 'Body'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _triggerNotification();
              },
              child: Text('Send Notification'),
            ),
             SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                
                //_updateDatabase();
              },
              child: Text('Update Database'),
            ),
          ],
        ),
      ),
    );
  }
  int createUniqueId(){
    return DateTime.now().millisecondsSinceEpoch.remainder(10);
  }
  void _triggerNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: titleController.text,
        body: bodyController.text,
      ),
    );
  }
  void _updateDatabase() async {
    // Run the Python script to update the database
    ProcessResult result = await Process.run(
      'python3',
      ['/Users/tugberkdikmen/Desktop/Fall-23/CS491/PriceWise Frontend/PriceWise/front-end/lib/scrape/update_database.py'],
    );

    // Check if the process was successful
    if (result.exitCode == 0) {
      print('Database update successful');
    } else {
      print('Database update failed');
      print(result.stderr);
    }
}
}