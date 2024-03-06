import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pwfe/components/text-form-fields/text_form_field_blue_darker.dart';
import 'package:pwfe/pages/HomePage.dart';
import 'package:pwfe/database/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pwfe/database/firebase_auth.dart';
import 'package:pwfe/pages/SigninPage.dart';
import 'package:pwfe/components/widgets/form_container_widget.dart';
import 'package:pwfe/components/alerts/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpPage> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool isSigningUp = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // use these to gather text from text form fields
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
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
              const Text(
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
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "Full Name",
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(27),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(27),
                    borderSide: BorderSide(
                      color: Colors.blue[200]!,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.lightBlue[200],
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(27),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(27),
                    borderSide: BorderSide(
                      color: Colors.blue[200]!,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.lightBlue[200],
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(
                    color: Colors
                        .black, // Color for when the TextFormField is not focused
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(27),
                    borderSide: const BorderSide(
                      color: Colors
                          .blue, // Border color when the TextFormField is focused
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(27),
                    borderSide: BorderSide(
                      color: Colors.blue[
                          100]!, // Border color when TextFormField is enabled
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
                controller: _confirmPasswordController,
                obscureText: !_isConfirmPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: const TextStyle(
                    color: Colors
                        .black, // Color for when the TextFormField is not focused
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(27),
                    borderSide: const BorderSide(
                      color: Colors
                          .blue, // Border color when the TextFormField is focused
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(27),
                    borderSide: BorderSide(
                      color: Colors.blue[
                          100]!, // Border color when TextFormField is enabled
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
                //onPressed: () {
                onPressed: ()  {
                  _signUp();
                  /*if(isSigningUp == true){//bu doğru çalışmıyor ama sebep ne??
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const SignInPage()), // Use the class name of your sign-in page
                  );
                  }*/
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                child: Center(
                      child: isSigningUp ? CircularProgressIndicator(color: Colors.white,):Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                //const Text('Sign Up'),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInPage()),
                            (route) => false);
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  
void _signUp() async {
  setState(() {
    isSigningUp = true;
  });

  final String username = _usernameController.text;
  final String email = _emailController.text;
  final String password = _passwordController.text;
  final String confirmPassword = _confirmPasswordController.text;

  if (password != confirmPassword) {
    showToast(message: "Passwords do not match");
    setState(() {
      isSigningUp = false;
    });
    return;
  }

  try {
    // This assumes _auth is your FirebaseAuth instance.
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = userCredential.user;

    if (user != null) {
      // Successfully created the user, now add the extra user information to Firestore
      await FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
        'email': email,
        'fullName': username,
        'city': 'Ankara',  // Default city
        // Any additional fields you need
      });

      showToast(message: "User successfully created");
      
      // Optionally, navigate to the home page or verify email
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()), // Make sure you have HomePage imported correctly
        (route) => false,
      );
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      showToast(message: "The password provided is too weak.");
    } else if (e.code == 'email-already-in-use') {
      showToast(message: "An account already exists for that email.");
    } else {
      showToast(message: "Firebase Auth Error: ${e.message}");
    }
  } catch (e) {
    showToast(message: "An unexpected error occurred. Please try again later.");
  } finally {
    // Ensure that we always stop the loading indicator, even if there's an error.
    setState(() {
      isSigningUp = false;
    });
  }
}

}