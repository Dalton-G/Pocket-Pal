import 'package:flutter/material.dart';
import 'package:pocket_pal/theme/app_theme.dart';

// Class
class EditPhoneTextField extends StatefulWidget {
  // Attributes
  final TextEditingController controller;
  final double width;

  // Constructor
  const EditPhoneTextField({
    Key? key,
    required this.controller,
    required this.width,
  });

  @override
  State<EditPhoneTextField> createState() => EditPhoneTextFieldState();
}

class EditPhoneTextFieldState extends State<EditPhoneTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: 50,
      child: TextFormField(
        controller: widget.controller,
        obscureText: false,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Field is required';
          } else if (!((value.length == 10) || (value.length == 11)) ||
              !RegExp(r'^[0-9]*$').hasMatch(value)) {
            return "Invalid phone number format, must be between least 10-11 digits";
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone, color: AppTheme.primaryGreen),
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
          hintText: "Phone",
          hintStyle: AppTheme.textFieldHint1,
        ),
      ),
    );
  }
}
