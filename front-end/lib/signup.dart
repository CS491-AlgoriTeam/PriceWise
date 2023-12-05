import 'package:flutter/material.dart';
import 'package:pwfe/main.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpPage> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              SizedBox(height: screenSize.height * 0.1),
              Text(
                'PriceWise',
                style: TextStyle(
                  fontFamily: 'Jockey One',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              SizedBox(height: screenSize.height * 0.04),
              Text(
                'Create Account Now!',
                style: TextStyle(
                  fontFamily: 'Jockey One',
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: screenSize.height * 0.05),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  labelStyle: TextStyle(
                    color: Colors.black, // Color for when the TextFormField is not focused
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(27),
                    borderSide: BorderSide(
                      color: Colors.blue, // Border color when the TextFormField is focused
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(27),
                    borderSide: BorderSide(
                      color: Colors.blue[200]!, // Border color when TextFormField is enabled
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.lightBlue[200],
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Colors.black, // Color for when the TextFormField is not focused
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(27),
                    borderSide: BorderSide(
                      color: Colors.blue, // Border color when the TextFormField is focused
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(27),
                    borderSide: BorderSide(
                      color: Colors.blue[200]!, // Border color when TextFormField is enabled
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.lightBlue[200],
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              TextFormField(
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Colors.black, // Color for when the TextFormField is not focused
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(27),
                    borderSide: BorderSide(
                      color: Colors.blue, // Border color when the TextFormField is focused
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(27),
                    borderSide: BorderSide(
                      color: Colors.blue[100]!, // Border color when TextFormField is enabled
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.lightBlue[100],
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              TextFormField(
                obscureText: !_isConfirmPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(
                    color: Colors.black, // Color for when the TextFormField is not focused
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(27),
                    borderSide: BorderSide(
                      color: Colors.blue, // Border color when the TextFormField is focused
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(27),
                    borderSide: BorderSide(
                      color: Colors.blue[100]!, // Border color when TextFormField is enabled
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.lightBlue[100],
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.05),
              ElevatedButton(
                onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()), // Use the class name of your sign-in page
                  );},
                child: Text('Sign Up'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
