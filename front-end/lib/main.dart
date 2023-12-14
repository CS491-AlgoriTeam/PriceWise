// main.dart
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:pwfe/classes/Product.dart';
import 'package:pwfe/classes/User.dart';
import 'package:pwfe/utils/DatabaseHelper.dart';

import 'package:sqflite/sqflite.dart';

import 'package:pwfe/classes/UsersShoppingLists.dart';
import 'package:pwfe/pages/HomePage.dart';

import 'package:pwfe/pages/MyShoppingListsPage.dart';

import 'pages/SigninPage.dart'; // Import the sign-in page
import 'pages/SignupPage.dart'; // Import the sign-up page

// flutter_svg to make custom buttons from icons

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper databaseHelper = DatabaseHelper();
  await databaseHelper.initDatabase(); // Wait for initialization to complete

  databaseHelper.insertUser(User(
      userID: 1,
      userName: "deniz",
      userSurname: "userSurname",
      userEmail: "xd",
      userPassword: "userPassword"));

  /*databaseHelper
      .insertProduct(Product(productName: "product1", productPrice: 1.0));

  databaseHelper.insertProduct(Product(
      productName: "product2",
      productPrice: 2.0)); // Insert a product into the database
    */
  print(await databaseHelper.getUserMapList());
  //print(await databaseHelper.getProductMapList());
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
