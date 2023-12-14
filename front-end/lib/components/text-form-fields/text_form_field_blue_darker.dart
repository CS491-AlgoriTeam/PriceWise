import 'package:flutter/material.dart';

TextFormField text_form_field_blue_darker(String text) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: text,
      labelStyle: const TextStyle(
        color: Colors.black, // Color for when the TextFormField is not focused
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(27),
        borderSide: const BorderSide(
          color: Colors.blue, // Border color when the TextFormField is focused
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(27),
        borderSide: BorderSide(
          color:
              Colors.blue[200]!, // Border color when TextFormField is enabled
        ),
      ),
      filled: true,
      fillColor: Colors.lightBlue[200],
    ),
  );
}
TextFormField text_form_field_blue_darker_with_controller(String text, TextEditingController controller) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: text,
      labelStyle: const TextStyle(
        color: Colors.black, // Color for when the TextFormField is not focused
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(27),
        borderSide: const BorderSide(
          color: Colors.blue, // Border color when the TextFormField is focused
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(27),
        borderSide: BorderSide(
          color:
              Colors.blue[200]!, // Border color when TextFormField is enabled
        ),
      ),
      filled: true,
      fillColor: Colors.lightBlue[200],
    ),
  );
}
