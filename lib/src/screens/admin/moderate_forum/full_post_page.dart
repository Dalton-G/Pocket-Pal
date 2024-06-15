import 'package:flutter/material.dart';
import 'package:pocket_pal/theme/app_theme.dart';

class FullPostPage extends StatelessWidget {
  final Map<String, dynamic> postData;

  const FullPostPage({Key? key, required this.postData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extract necessary data from postData
    final String title = postData['title'];
    final String description = postData['description'];
    final String thumbnail = postData['thumbnail'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Full Post'),
        actions: [
          IconButton(
            icon: Icon(Icons.report),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.favorite_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTheme.largeTextGrey,
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: AppTheme.normalTextGreen,
              ),
              SizedBox(height: 16),
              Image.network(thumbnail),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
