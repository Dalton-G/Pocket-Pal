import 'package:flutter/material.dart';

class ButtonFill extends StatelessWidget {
  final String text;
  final Color txtColor;
  final Color btnColor;
  final VoidCallback onPressed;

  const ButtonFill({
    Key? key,
    required this.text,
    required this.btnColor,
    required this.txtColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 60),
      child: ElevatedButton(
        clipBehavior: Clip.none,
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          backgroundColor: btnColor,
        ),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: txtColor,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class ShadowButton extends StatelessWidget {
  final String text;
  final Color txtColor;
  final Color btnColor;
  final Function()? onPressed;

  const ShadowButton({
    Key? key,
    required this.text,
    required this.txtColor,
    required this.btnColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.8),
                offset: Offset(3, 4),
                spreadRadius: 2,
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(8, 15, 8, 15),
            decoration: BoxDecoration(
              color: btnColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: txtColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
