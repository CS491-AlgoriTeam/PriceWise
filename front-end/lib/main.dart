// main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:pwfe/classes/Product.dart';
import 'package:pwfe/classes/ShoppingList.dart';
import 'package:pwfe/classes/ShoppingListsData.dart';
import 'package:pwfe/classes/User.dart';
import 'package:pwfe/utils/DatabaseHelper.dart';

import 'package:sqflite/sqflite.dart';

import 'package:pwfe/classes/UsersShoppingLists.dart';
import 'package:pwfe/pages/HomePage.dart';

import 'package:pwfe/pages/MyShoppingListsPage.dart';

import 'pages/SigninPage.dart'; // Import the sign-in page
import 'pages/SignupPage.dart'; // Import the sign-up page

// flutter_svg to make custom buttons from icons

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    runApp(const MyApp());
  } catch (e) {
    print("Firebase initialization error: $e");
    // Handle the error or display an error message to the user
  }
  /*DatabaseHelper databaseHelper = DatabaseHelper();
  await databaseHelper.initDatabase(); // Wait for initialization to complete

  databaseHelper.insertUser(User(
      userID: 1,
      userName: "deniz",
      userSurname: "userSurname",
      userEmail: "xd",
      userPassword: "123"));

  databaseHelper
      .insertProduct(Product(productName: "Muz", productPrice: 1.0));

  databaseHelper.insertProduct(Product(
      productName: "Elma",
      productPrice: 1.5));
  databaseHelper.insertProduct(Product(
      productName: "Armut",
      productPrice: 2.5));
  databaseHelper.insertProduct(Product(
      productName: "Solo Tuvalet Kağıdı",
      productPrice: 5.0));
  databaseHelper.insertProduct(Product(
      productName: "Ülker Çikolatalı Gofret",
      productPrice: 1.05)); // Insert a product into the database
  databaseHelper.insertProduct(Product(
      productName: "Domates",
      productPrice: 3.5));
  databaseHelper.insertProduct(Product(
      productName: "Lays Cips Sade",
      productPrice: 0.99));
  databaseHelper.insertProduct(Product(
      productName: "Selpak Tuvalet Kağıdı",
      productPrice: 5.0));
  databaseHelper.insertProduct(Product(
      productName: "Eti Çikolatalı Gofret",
      productPrice: 1.05));
/*
 // ShoppingList shoppingList1 = ShoppingList(
      shoppingListName: "shoppingList1",
      products: [Product(productName: "product1", productPrice: 1.0)]);

  //ShoppingList shoppingList2 = ShoppingList(shoppingListName: "shoppingList2", products: [Product(productName: "product2", productPrice: 2.0)]);
*/
  // shopping list datası patlado
  print(await databaseHelper.getUserMapList());
  print(await databaseHelper.getProductMapList());*/
  
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
