// main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pwfe/pages/HomePage.dart';
import 'package:pwfe/pages/MyShoppingListsPage.dart';
import 'pages/SigninPage.dart'; // Import the sign-in page
import 'pages/SignupPage.dart'; // Import the sign-up page

// flutter_svg to make custom buttons from icons

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  FirebaseOptions firebaseOptions;

  // Check the platform
  if (Platform.isAndroid) {
    // Android-specific Firebase options
    firebaseOptions = const FirebaseOptions(
      apiKey: "AIzaSyCySbCT34duT0KjRUuBB63yXqc2D5TQ7eU",
      appId: "1:880861676478:android:55ca897f4c1bc682f02fef",
      messagingSenderId: "880861676478",
      projectId: "pricewise-cs",
    );
    await Firebase.initializeApp(
    options: firebaseOptions,
    );
  } 
  else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PriceWise',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
      // You can also define the route here if you prefer named routes
      routes: {
        '/homePage': (context) => const HomePage(),
        '/signin': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/myShoppingLists': (context) => MyShoppingLists(),
      },
    );
  }
}
