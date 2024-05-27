import 'package:flutter/material.dart';
import 'package:pocket_pal/theme/app_theme.dart';

// Class
class DateTextField extends StatefulWidget {
  // Attributes
  final TextEditingController controller;
  final double width;

  // Constructor
  const DateTextField({
    Key? key,
    required this.controller,
    required this.width,
  });

  @override
  State<DateTextField> createState() => DateTextFieldState();
}

class DateTextFieldState extends State<DateTextField> {
  Future<void> selectDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        widget.controller.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

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
          } else if (value.contains('@') && value.contains('.')) {
            return "Invalid email format, must include '@' and '.')";
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.calendar_today, color: AppTheme.primaryGreen),
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
          hintText: "Date of Birth",
          hintStyle: AppTheme.textFieldHint1,
        ),
        readOnly: true,
        onTap: selectDate,
      ),
    );
  }
}
