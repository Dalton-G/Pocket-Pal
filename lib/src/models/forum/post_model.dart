import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  final String title;
  final String description;
  final String thumbnail;
  final String likesCount;
  final String bookmarkCount;
  final String commentsCount;
  final String badgeId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String authorId;
  final String category;
  final bool isReported;

  PostModel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.likesCount,
    required this.bookmarkCount,
    required this.commentsCount,
    required this.badgeId,
    required this.createdAt,
    required this.updatedAt,
    required this.authorId,
    required this.category,
    required this.isReported,
  });

  factory PostModel.fromDocument(DocumentSnapshot doc) {
    return PostModel(
      id: doc['id'],
      title: doc['title'],
      description: doc['description'],
      thumbnail: doc['thumbnail'],
      likesCount: doc['likes_count'],
      bookmarkCount: doc['bookmark_count'],
      commentsCount: doc['comments_count'],
      badgeId: doc['badge_id'],
      createdAt: (doc['created_at'] as Timestamp).toDate(),
      updatedAt: (doc['updated_at'] as Timestamp).toDate(),
      authorId: doc['author_id'],
      category: doc['category_id'],
      isReported: doc['is_reported'],
    );
  }
}
