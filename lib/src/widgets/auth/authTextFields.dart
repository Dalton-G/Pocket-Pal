import 'package:flutter/material.dart';
import 'package:pocket_pal/theme/app_theme.dart';

// Class
class AuthTextField extends StatefulWidget {
  // Attributes
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Color mainColor;
  final double width;

  // Constructor
  const AuthTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.mainColor,
    required this.width,
  });

  @override
  State<AuthTextField> createState() => AuthTextFieldState();
}

class AuthTextFieldState extends State<AuthTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: 50,
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Field is required';
          }
          return null;
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.mainColor),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.mainColor),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: widget.mainColor,
          filled: true,
          hintText: widget.hintText,
          hintStyle: AppTheme.textFieldHint1,
        ),
      ),
    );
  }
}
