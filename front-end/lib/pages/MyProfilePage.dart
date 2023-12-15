// profile_page.dart
import 'package:flutter/material.dart';
import 'package:pwfe/pages/MyHistoryPage.dart';

class MyProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Replace with actual image url
              ),
            ),
          ),
          TextSection(title: 'Name', content: 'Deniz'),
          TextSection(title: 'City', content: 'Ankara'),
          TextSection(title: 'Country', content: 'Turkey'),
          TextSection(title: 'Email', content: 'deniz@example.com'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement change password functionality
              },
              child: Text('Change Password'),
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlue, // background (button) color
                onPrimary: Colors.white, // foreground (text) color
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement history functionality
              },
              child: Text('History'),
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlue, // background (button) color
                onPrimary: Colors.white, // foreground (text) color
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextSection extends StatelessWidget {
  final String title;
  final String content;

  const TextSection({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: Text('$title:', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 3, child: Text(content)),
        ],
      ),
    );
  }
}


/*class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyProfilePage'),
      ),
      body: ListView.builder(
        itemCount: 10, // Set the number of items in your list
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('Item $index'),
            onTap: () {
              // Add your item click logic here
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyHistoryPage()));
            },
          );
        },
      ),
    );
  }
}
*/