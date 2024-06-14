import 'package:flutter/material.dart';
import 'package:pocket_pal/src/widgets/forum/common_post_page.dart';

const String _category = 'Depression';

class DepressionPostPage extends StatefulWidget {
  const DepressionPostPage({super.key});

  @override
  State<DepressionPostPage> createState() => _DepressionPostPageState();
}

class _DepressionPostPageState extends State<DepressionPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildPostPage(getPostStream(_category), _category));
  }
}
