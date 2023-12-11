// main.dart
import 'package:flutter/material.dart';
import 'package:pwfe/classes/UsersShoppingLists.dart';
import 'package:pwfe/pages/HomePage.dart';
import 'package:pwfe/pages/MyShoppingListsPage.dart';
import 'pages/SigninPage.dart'; // Import the sign-in page
import 'pages/SignupPage.dart'; // Import the sign-up page

// flutter_svg to make custom buttons from icons

void main() {
  initializeUsersShoppingLists();
  runApp(const MyApp());
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

void initializeUsersShoppingLists() {
  UsersShoppingLists testingShoppingLists = UsersShoppingLists.instance;
  testingShoppingLists.addShoppingList("shoppingList1");
  testingShoppingLists.addShoppingList("shoppingList2");
  testingShoppingLists.addShoppingList("shoppingList3");
  testingShoppingLists.addShoppingList("shoppingList4");

  testingShoppingLists.addProductToShoppingList(0, "list1_item1", 11.0);
  testingShoppingLists.addProductToShoppingList(0, "list1_item2", 12.0);
  testingShoppingLists.addProductToShoppingList(0, "list1_item3", 13.0);
  testingShoppingLists.addProductToShoppingList(0, "list1_item4", 14.0);
  testingShoppingLists.addProductToShoppingList(1, "list2_item1", 21.0);
  testingShoppingLists.addProductToShoppingList(1, "list2_item2", 22.0);
  testingShoppingLists.addProductToShoppingList(1, "list2_item3", 23.0);
  testingShoppingLists.addProductToShoppingList(1, "list2_item4", 24.0);
  testingShoppingLists.addProductToShoppingList(2, "list3_item1", 31.0);
  testingShoppingLists.addProductToShoppingList(2, "list3_item2", 32.0);
  testingShoppingLists.addProductToShoppingList(2, "list3_item3", 33.0);
  testingShoppingLists.addProductToShoppingList(2, "list3_item4", 34.0);
  testingShoppingLists.addProductToShoppingList(3, "list4_item1", 41.0);
  testingShoppingLists.addProductToShoppingList(3, "list4_item2", 42.0);
  testingShoppingLists.addProductToShoppingList(3, "list4_item3", 43.0);
  testingShoppingLists.addProductToShoppingList(3, "list4_item4", 44.0);
}

/*class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Getting screen size
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: screenSize.height * 0.07),
            // Text with PriceWise in the middle, bold and dark blue
            Center(
              child: Text(
                'PriceWise',
                style: TextStyle(
                  fontFamily: 'Jockey One',
                  fontSize: 45,
                  fontWeight: FontWeight.bold, // Make text bold
                  color: Colors.blue[900], // Dark blue color
                ),
              ),
            ),

            SizedBox(height: screenSize.height * 0.05),
            // Illustration
            Image.asset(
              'assets/logo.png',
              width: screenSize.width * 0.7,
              height: screenSize.height * 0.25,
            ),
            SizedBox(height: screenSize.height * 0.05),
            // Welcome Text
            Text(
              'Hello, Welcome!',
              style: TextStyle(
                fontFamily: 'Jockey One',
                fontSize: 36,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome To PriceWise\nYour User Friendly Money Saving App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: screenSize.height * 0.05),
            // Login Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ourButton(
                  context, "Sign tubiş", (context) => SignInPage()),
            ),
            SizedBox(height: screenSize.height * 0.02),
            // Sign Up Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SignUpPage()), // Use the class name of your sign-in page
                  );
                },
                child: Text('Sign Up'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue[300],
                  foregroundColor: Colors.white,
                  minimumSize: Size(330, 54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  textStyle: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: double.infinity, height: screenSize.height * 0.02),
            // Continue Without Register Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Continue Without Register'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue[300],
                  foregroundColor: Colors.white,
                  minimumSize: Size(330, 54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  textStyle: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }*/
//}
