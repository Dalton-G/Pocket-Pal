import 'package:flutter/material.dart';
import 'package:pocket_pal/src/widgets/forum/common_post_page.dart';

const String _category = 'Loneliness';

class LonelinessPostPage extends StatefulWidget {
  const LonelinessPostPage({super.key});

  @override
  State<LonelinessPostPage> createState() => _LonelinessPostPageState();
}

class _LonelinessPostPageState extends State<LonelinessPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildPostPage(getPostStream(_category), _category));
  }
}
