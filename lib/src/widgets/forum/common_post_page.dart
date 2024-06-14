import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pocket_pal/src/providers/forum/post_provider.dart';
import 'package:pocket_pal/src/widgets/auth/alertDialog.dart';
import 'package:pocket_pal/src/widgets/forum/post_list_tile.dart';
import 'package:pocket_pal/theme/app_theme.dart';

final PostProvider _postProvider = PostProvider();

Stream<QuerySnapshot<Map<String, dynamic>>> getPostStream(String category) {
  return FirebaseFirestore.instance
      .collection('posts')
      .where('category', isEqualTo: category)
      .where('is_reported', isEqualTo: false)
      .snapshots();
}

Stream<QuerySnapshot<Map<String, dynamic>>> getReportedPostStream() {
  return FirebaseFirestore.instance
      .collection('posts')
      .where('is_reported', isEqualTo: true)
      .snapshots();
}

Widget buildPostPage(
    Stream<QuerySnapshot<Map<String, dynamic>>> stream, String category) {
  return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
    stream: stream,
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      }

      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return const Center(child: CircularProgressIndicator());
        default:
          return snapshot.hasData && snapshot.data!.docs.isNotEmpty
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final postDoc = snapshot.data!.docs[index];
                    final postData = postDoc.data();
                    final title = postData['title'];
                    final description = postData['description'];
                    final thumbnail = postData['thumbnail'];
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: const StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (BuildContext context) {
                              _postProvider.reportPost(postData['id']);
                              showAuthDialog(
                                context,
                                'Post Reported!',
                                'This post has been reported to admin. Thank you for keeping the community clean!',
                              );
                            },
                            icon: Icons.report,
                            label: 'Report',
                            backgroundColor: AppTheme.primaryOrange,
                          ),
                        ],
                      ),
                      child: PostListTile(
                        title: title,
                        description: description,
                        thumbnail: thumbnail,
                      ),
                    );
                  },
                )
              : Center(child: Text('No $category posts found.'));
      }
    },
  );
}

Widget buildReportedPostPage(
    Stream<QuerySnapshot<Map<String, dynamic>>> stream) {
  return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
    stream: stream,
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      }

      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return const Center(child: CircularProgressIndicator());
        default:
          return snapshot.hasData && snapshot.data!.docs.isNotEmpty
              ? ListView.builder(
                  itemCount: snapshot.data?.docs.length ?? 0,
                  itemBuilder: (context, index) {
                    final postDoc = snapshot.data!.docs[index];
                    final postData = postDoc.data();
                    final title = postData['title'];
                    final description = postData['description'];
                    final thumbnail = postData['thumbnail'];

                    return Slidable(
                        endActionPane: ActionPane(
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (BuildContext context) => {
                                _postProvider.deletePost(
                                    postData['id'], postData['thumbnail'])
                              },
                              icon: Icons.delete,
                              label: 'Delete',
                              backgroundColor: AppTheme.primaryOrange,
                            ),
                          ],
                        ),
                        startActionPane: ActionPane(
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (BuildContext context) =>
                                  _postProvider.revertPost(postData['id']),
                              icon: Icons.undo,
                              label: 'Revert',
                              backgroundColor: AppTheme.primaryBlue,
                            ),
                          ],
                        ),
                        child: PostListTile(
                            title: title,
                            description: description,
                            thumbnail: thumbnail));
                  },
                )
              : Center(
                  child: Text('No Reported posts found.'),
                );
      }
    },
  );
}
