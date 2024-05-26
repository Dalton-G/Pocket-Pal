// error_dialog.dart
import 'package:flutter/material.dart';
import 'package:pocket_pal/theme/app_theme.dart';

class AuthErrorDialog extends StatelessWidget {
  // Attributes
  final String title;
  final String content;

  // Constructor
  const AuthErrorDialog({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: AppTheme.mediumTextGreen,
      ),
      content: Text(
        content,
        style: AppTheme.normalTextGrey,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}

// Method
void showAuthErrorDialog(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AuthErrorDialog(
        title: title,
        content: content,
      );
    },
  );
}
