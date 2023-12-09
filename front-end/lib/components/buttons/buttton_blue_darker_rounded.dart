import 'package:flutter/material.dart';

ElevatedButton buttton_blue_darker_rounded(
    BuildContext context, String text, Widget Function(BuildContext) route) {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => route(context),
        ),
      );
    },
    child: Text(text),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.lightBlue,
      foregroundColor: Colors.white,
      minimumSize: Size(330, 54),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(47),
      ),
      padding: EdgeInsets.symmetric(vertical: 10),
      textStyle: TextStyle(
        fontFamily: 'Inter',
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
