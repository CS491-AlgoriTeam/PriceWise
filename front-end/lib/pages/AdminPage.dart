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

  ElevatedButton _homePageStyleButton(String text, Function() onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        //primary: Colors.lightBlue,
        //onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(27),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(27),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(27),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: bodyController,
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Body',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(27),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(27),
                ),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: _homePageStyleButton(
                  'Send Notification', _triggerNotification),
            ),
            SizedBox(height: 20),
            Center(
              child: _homePageStyleButton('Update Database', _updateDatabase),
            ),
          ],
        ),
      ),
    );
  }

  int createUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100);
  }

  void _triggerNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(

        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: titleController.text,
        body: bodyController.text,
        
        showWhen: true,
        notificationLayout: NotificationLayout.BigText,
        payload: {'notification_details': 'true'},
      ),
    );
  }

  void _updateDatabase() async {
    // Run the Python script to update the database
    ProcessResult result = await Process.run(
      'python3',
      [
        '/Users/tugberkdikmen/Desktop/Fall-23/CS491/PriceWise Frontend/PriceWise/front-end/lib/scrape/update_database.py'
      ],
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
