// profile_page.dart
/*import 'package:flutter/material.dart';
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
}*/

/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';

class MyProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<MyProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  List<DocumentSnapshot> _deletedLists = [];

  @override
  void initState() {
    super.initState();
    _fetchDeletedLists();
  }

  void _fetchDeletedLists() async {
    final uid = user?.uid;
    if (uid == null) return;

    final result = await FirebaseFirestore.instance
        .collection('deletedShoppingLists')
        .where('userId', isEqualTo: uid)
        .orderBy('deletedAt', descending: true)
        .get();

    setState(() {
      _deletedLists = result.docs;
    });
  }

  Widget _buildDeletedListTile(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ListTile(
      title: Text(data['listName']),
      trailing: IconButton(
        icon: Icon(Icons.restore_from_trash),
        onPressed: () {
          // Implement functionality to restore or permanently delete the list
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Placeholder(fallbackHeight: 100.0), // Placeholder for icon picture
                  SizedBox(height: 20),
                  Text('Name: ${user?.displayName }'),
                  Text('E-Mail: ${user?.email }'),
                  Text('Location: ${'User\'s Location Info'}'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Implement change password functionality
                    },
                    child: Text('Change Password'),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Deleted Lists',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  ..._deletedLists.map((doc) => _buildDeletedListTile(doc)).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: navigation_bar_bottom(context), // Reuse the existing navigation bar code
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';

class MyProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<MyProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  List<DocumentSnapshot> _deletedLists = [];
  String _fullName = 'User\'s Full Name';
  String _city = 'User\'s Location Info';

  @override
  void initState() {
    super.initState();
    _fetchDeletedLists();
    _fetchUserProfile();

  }

void _fetchUserProfile() async {
  final uid = user?.uid;
  if (uid == null) return;

  try {
    DocumentSnapshot userProfile = await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .get();

    if (userProfile.exists) {
      Map<String, dynamic> data = userProfile.data() as Map<String, dynamic>;
      setState(() {
        _fullName = data['fullName'] ?? _fullName;
        _city = data['city'] ?? _city;
      });
    }
  } catch (e) {
    print('Error fetching user profile: $e');
    // Handle errors or show an alert to the user
  }
}

  void _fetchDeletedLists() async {
    final uid = user?.uid;
    if (uid == null) return;

    final result = await FirebaseFirestore.instance
        .collection('deletedShoppingLists')
        .where('userId', isEqualTo: uid)
        .orderBy('deletedAt', descending: true)
        .get();

    setState(() {
      _deletedLists = result.docs;
    });
  }

  /*Widget _buildDeletedListTile(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: ListTile(
        title: Text(data['listName'] ?? 'Unknown List', textAlign: TextAlign.center),
        trailing: IconButton(
          icon: Icon(Icons.restore_from_trash),
          onPressed: () {
            // Implement functionality to restore or permanently delete the list
          },
        ),
      ),
    );
  }*/
  Widget _buildDeletedListTile(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    
    Future<void> _restoreDeletedList(String docId) async {
    // Step 1: Prepare the data for "shoppingLists" by removing 'deletedAt'
    Map<String, dynamic> restoredData = Map.from(data)..remove('deletedAt');
    
    // Step 2: Add the restored data to "shoppingLists"
    await FirebaseFirestore.instance.collection('shoppingLists').add(restoredData);
    
    // Step 3: Delete the list from "deletedShoppingLists"
    await FirebaseFirestore.instance.collection('deletedShoppingLists').doc(docId).delete();
    
    // Step 4: Update UI
    _fetchDeletedLists();
  }
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.lightBlue[200],
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: ListTile(
        title: Text(data['listName'] ?? 'Unknown List', textAlign: TextAlign.left),
        trailing: Container(
          decoration: BoxDecoration(
            color: Colors.blue[100], // Choose the color for your circle here
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(Icons.restore_from_trash),
            onPressed: () {
              _restoreDeletedList(doc.id);            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.lightBlue[50],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: [
                  Container(
                    height: 170.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300], // This color will be visible if the image has transparency
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0), // Ensures the image has the same rounded corners as the container
                      child: Image.asset(
                        'assets/profilePageBG.webp',
                        fit: BoxFit.cover, // Covers the whole area of the container
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Name: $_fullName', textAlign: TextAlign.center),
                  Text('E-Mail: ${user?.email ?? 'User\'s full Email'}', textAlign: TextAlign.center),
                  Text('Location: $_city' + ', Türkiye', textAlign: TextAlign.center),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Implement change password functionality
                    },
                    child: Text('Change Password',
                    style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      
                      ),
                    ),
                  ),
                ],
              ),
            ),
      
            Container(
              padding: EdgeInsets.all(12.0),
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Deleted Lists',
                    style: TextStyle(
                          color: Colors.black, // Custom color for the title
                          fontWeight: FontWeight.bold, // Bold text
                          fontSize: 24, // Custom font size
                        ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  ..._deletedLists.map((doc) => _buildDeletedListTile(doc)).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: navigation_bar_bottom(context), // Reuse the existing navigation bar code
    );
  }
}
