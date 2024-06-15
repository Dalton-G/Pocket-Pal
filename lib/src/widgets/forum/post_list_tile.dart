import 'package:flutter/material.dart';
import 'package:pocket_pal/theme/app_theme.dart';

class PostListTile extends StatelessWidget {
  final String title;
  final String description;
  final String thumbnail;

  const PostListTile({
    super.key,
    required this.title,
    required this.description,
    required this.thumbnail,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: AppTheme.normalTextGrey),
      subtitle: Text(description),
      tileColor: AppTheme.secondaryGreen,
      trailing: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FadeInImage(
          height: 80,
          width: 80,
          fit: BoxFit.cover,
          placeholder:
              AssetImage('lib/src/assets/images/placeholder_image.png'),
          image: NetworkImage(thumbnail),
        ),
      ),
      contentPadding: const EdgeInsets.all(10),
    );
  }
}
