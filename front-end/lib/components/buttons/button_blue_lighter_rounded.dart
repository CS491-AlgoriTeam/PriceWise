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
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.lightBlue[300],
      foregroundColor: Colors.white,
      minimumSize: const Size(330, 54),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(27),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      textStyle: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    child: Text(text),
  );
}
