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
}/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pwfe/components/alerts/toast.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          Flexible(child: Text(content, textAlign: TextAlign.right)),
        ],
      ),
    );
  }
}

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic> userData = {};
  List<Map<String, dynamic>> deletedLists = [];
  List<String> cities = ['Ankara', 'Istanbul', 'Izmir', 'Antalya', 'Adana'];
  String? selectedCity;

  @override
  void initState() {
    super.initState();
    if (user != null) {
      _fetchUserData();
      _fetchDeletedLists();
    }
  }

  Future<void> _fetchUserData() async {
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Users').doc(user.uid).get();
        if (userDoc.exists) {
          setState(() {
            userData = userDoc.data() as Map<String, dynamic>;
            selectedCity = userData['city'] ?? cities.first;
          });
        }
      } catch (e) {
        showToast(message: "Error fetching user data: $e");
      }
    }
  }

  Future<void> _fetchDeletedLists() async {
    if (user != null) {
      try {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('deletedShoppingLists')
            .where('userId', isEqualTo: user!.uid)
            .orderBy('deletedAt', descending: true)
            .limit(5)
            .get();
        setState(() {
          deletedLists = snapshot.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();
        });
      } catch (e) {
        showToast(message: "Error fetching deleted lists: $e");
      }
    }
  }

  void _updateUserCity(String? city) async {
    if (user != null && city != null) {
      try {
        await FirebaseFirestore.instance.collection('Users').doc(user.uid).update({'city': city});
        showToast(message: "City updated successfully");
        _fetchUserData();
      } catch (e) {
        showToast(message: "Failed to update city: $e");
      }
    }
  }

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 32),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(userData['photoUrl'] ?? 'https://via.placeholder.com/150'),
            ),
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.lightBlue[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  TextSection(title: 'Name', content: userData['fullName'] ?? 'Name not set'),
                  TextSection(title: 'Email', content: userData['email'] ?? 'Email not set'),
                  TextSection(title: 'City', content: userData['city'] ?? 'City not set'),
                  TextSection(title: 'Country', content: userData['country'] ?? 'Turkey'),
                  DropdownButtonFormField<String>(
                    value: selectedCity,
                    decoration: InputDecoration(
                      labelText: "City",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String? newCity)
{
setState(() {
selectedCity = newCity;
});
_updateUserCity(newCity);
},
items: cities.map<DropdownMenuItem<String>>((String city) {
return DropdownMenuItem<String>(
value: city,
child: Text(city),
);
}).toList(),
),
],
),
),
Padding(
padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
child: ElevatedButton(
onPressed: () async {
if (user?.email != null) {
try {
await FirebaseAuth.instance.sendPasswordResetEmail(email: user!.email!);
showToast(message: 'Password reset email sent.');
} catch (e) {
showToast(message: 'Failed to send password reset email: $e');
}
}
},
child: Text('Change Password'),
style: ElevatedButton.styleFrom(
primary: Colors.lightBlue,
onPrimary: Colors.white,
),
),
),
Padding(
padding: const EdgeInsets.all(16.0),
child: Text('Deleted Lists', style: Theme.of(context).textTheme.headline6),
),
...deletedLists.map((list) {
String deletedDate = (list['deletedAt'] as Timestamp?)?.toDate().toString() ?? 'Unknown deletion date';
return ListTile(
title: Text(list['name'] ?? 'Unnamed list'),
subtitle: Text('Deleted on: $deletedDate'),
);
}).toList(),
],
),
),
);
}
}*/