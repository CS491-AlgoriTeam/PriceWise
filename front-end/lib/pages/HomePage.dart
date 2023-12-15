import 'package:flutter/material.dart';
import 'package:pwfe/components/buttons/buttton_blue_darker_rounded.dart';
import 'package:pwfe/components/buttons/button_blue_lighter_rounded.dart';
import 'package:pwfe/pages/SigninPage.dart';
import 'package:pwfe/pages/SignupPage.dart';
import 'package:pwfe/pages/MyShoppingListsPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            const Text(
              'Hello, Welcome!',
              style: TextStyle(
                fontFamily: 'Jockey One',
                fontSize: 36,
                color: Colors.black,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
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
              child: buttton_blue_darker_rounded(
                  context, "Sign In", (context) => const SignInPage()),
            ),
            SizedBox(height: screenSize.height * 0.02),
            // Sign Up Button
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: button_blue_lighter_rounded(
                    context, "Sign Up", (p0) => const SignUpPage())),
            SizedBox(width: double.infinity, height: screenSize.height * 0.02),
            // Continue Without Register Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: button_blue_lighter_rounded( context, "Continue Without Register", (p0) =>  MyShoppingLists())),
          ],
        ),
      ),
    );
  }
}
