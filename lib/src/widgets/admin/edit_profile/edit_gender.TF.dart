import 'package:flutter/material.dart';
import 'package:pocket_pal/theme/app_theme.dart';

// Class
class EditGenderTextField extends StatefulWidget {
  // Attributes
  final TextEditingController controller;
  final double width;

  // Constructor
  const EditGenderTextField({
    Key? key,
    required this.controller,
    required this.width,
  });

  @override
  State<EditGenderTextField> createState() => EditGenderTextFieldState();
}

class EditGenderTextFieldState extends State<EditGenderTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: 50,
      child: TextFormField(
        readOnly: true,
        controller: widget.controller,
        obscureText: false,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Field is required';
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.attribution, color: AppTheme.primaryGreen),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.secondaryGreen),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.secondaryGreen),
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
          fillColor: AppTheme.secondaryGreen,
          filled: true,
          hintText: "Gender",
          hintStyle: AppTheme.textFieldHint1,
        ),
      ),
    );
  }
}
