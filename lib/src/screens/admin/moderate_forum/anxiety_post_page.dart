import 'package:flutter/material.dart';
import 'package:pocket_pal/src/widgets/forum/common_post_page.dart'; // Import for Firestore

const String _category = 'Anxiety';

class AnxietyPostPage extends StatefulWidget {
  const AnxietyPostPage({super.key});

  @override
  State<AnxietyPostPage> createState() => _AnxietyPostPageState();
}

class _AnxietyPostPageState extends State<AnxietyPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPostPage(getPostStream(_category), _category),
    );
  }
}
