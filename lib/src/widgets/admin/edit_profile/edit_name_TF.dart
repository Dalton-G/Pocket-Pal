import 'package:flutter/material.dart';
import 'package:pocket_pal/theme/app_theme.dart';

// Class
class EditNameTextField extends StatefulWidget {
  // Attributes
  final TextEditingController controller;
  final String hintText;
  final double width;

  // Constructor
  const EditNameTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.width,
  });

  @override
  State<EditNameTextField> createState() => EditNameTextFieldState();
}

class EditNameTextFieldState extends State<EditNameTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width / 3.5,
      height: 50,
      child: TextFormField(
        controller: widget.controller,
        obscureText: false,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Field is required';
          }
          return null;
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.secondaryGreen),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.primaryGreen),
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
          fillColor: AppTheme.accentGreen,
          filled: true,
          hintText: widget.hintText,
          hintStyle: AppTheme.textFieldHint1,
        ),
      ),
    );
  }
}
