// custom_avatar.dart
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pocket_pal/theme/app_theme.dart';

// ignore: must_be_immutable
class CustomAvatar extends StatelessWidget {
  final VoidCallback onPressed;
  String? imagePath;
  Uint8List? imageSrc;

  CustomAvatar(
      {Key? key, required this.onPressed, this.imagePath, this.imageSrc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: imageSrc != null
              ? MemoryImage(imageSrc!)
              : AssetImage('lib/src/assets/images/avatar.png') as ImageProvider,
        ),
        Positioned(
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.add_a_photo,
              size: 15,
              color: AppTheme.black,
            ),
          ),
          bottom: -15,
          left: 15,
        ),
      ],
    );
  }
}
