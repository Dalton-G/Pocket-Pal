import 'package:flutter/material.dart';
import 'package:pocket_pal/theme/app_theme.dart';

// Class
class PasswordTextField extends StatefulWidget {
  // Attributes
  final TextEditingController controller;
  final double width;

  // Constructor
  const PasswordTextField({
    Key? key,
    required this.controller,
    required this.width,
  });

  @override
  State<PasswordTextField> createState() => PasswordTextFieldState();
}

class PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: 50,
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Field is required';
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.password, color: AppTheme.primaryGreen),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: AppTheme.primaryGreen,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
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
          hintText: "Password",
          hintStyle: AppTheme.textFieldHint1,
        ),
      ),
    );
  }
}
