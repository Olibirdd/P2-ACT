import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  const CustomTextField(
      {super.key, required this.controller, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Please enter your $text',
        hintStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(15)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $text';
        }
        return null;
      },
    );
  }
}
