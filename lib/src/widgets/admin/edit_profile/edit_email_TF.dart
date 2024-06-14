import 'package:flutter/material.dart';
import 'package:pocket_pal/theme/app_theme.dart';

// Class
class EditEmailTextField extends StatefulWidget {
  // Attributes
  final TextEditingController controller;
  final double width;

  // Constructor
  const EditEmailTextField({
    Key? key,
    required this.controller,
    required this.width,
  });

  @override
  State<EditEmailTextField> createState() => EditEmailTextFieldState();
}

class EditEmailTextFieldState extends State<EditEmailTextField> {
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
          } else if (!(value.contains('@') && value.contains('.'))) {
            return "Invalid email format, must include '@' and '.')";
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email, color: AppTheme.primaryGreen),
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
          hintText: "Email",
          hintStyle: AppTheme.textFieldHint1,
        ),
      ),
    );
  }
}
