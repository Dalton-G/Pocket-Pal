import 'package:flutter/material.dart';
import 'package:pocket_pal/theme/app_theme.dart';

// Class
class ViewTextField extends StatefulWidget {
  // Attributes
  final TextEditingController controller;
  final double width;
  final String labelText;

  // Constructor
  const ViewTextField({
    Key? key,
    required this.controller,
    required this.width,
    required this.labelText,
  });

  @override
  State<ViewTextField> createState() => ViewTextFieldState();
}

class ViewTextFieldState extends State<ViewTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextFormField(
        style: AppTheme.smallTextGrey,
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
          prefixText: "${widget.labelText} ",
          prefixStyle: AppTheme.smallTextGreen,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.primaryGreen),
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
          fillColor: AppTheme.backgroundWhite,
          filled: true,
        ),
      ),
    );
  }
}
