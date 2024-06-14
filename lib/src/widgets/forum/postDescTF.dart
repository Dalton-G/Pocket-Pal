import 'package:flutter/material.dart';
import 'package:pocket_pal/theme/app_theme.dart';

// Class
class PostDescTF extends StatefulWidget {
  // Attributes
  final TextEditingController controller;
  final double width;

  // Constructor
  const PostDescTF({
    Key? key,
    required this.controller,
    required this.width,
  });

  @override
  State<PostDescTF> createState() => PostDescTFState();
}

class PostDescTFState extends State<PostDescTF> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextFormField(
        controller: widget.controller,
        obscureText: false,
        maxLines: null,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Field is required';
          }
          return null;
        },
        style: AppTheme.normalTextGrey,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.description, color: AppTheme.primaryGreen),
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
          hintText: "Description",
          hintStyle: AppTheme.textFieldHint1,
        ),
      ),
    );
  }
}
