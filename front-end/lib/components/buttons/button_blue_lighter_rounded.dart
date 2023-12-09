import 'package:flutter/material.dart';

ElevatedButton button_blue_lighter_rounded(
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
  );
}
