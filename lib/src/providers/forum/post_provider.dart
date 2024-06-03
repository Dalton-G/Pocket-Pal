import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pocket_pal/src/models/forum/post_model.dart';
import 'package:uuid/uuid.dart';

class PostProvider extends ChangeNotifier {
  PostModel? _postModel;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  PostModel? get postModel => _postModel;

  Future<void> addNewpost(
    String authorId,
    String title,
    String description,
    Uint8List thumbnail,
    String category,
  ) async {
    try {
      final String id = Uuid().v4();
      final Timestamp now = Timestamp.now();
      String imageUrl = await uploadThumbnail('posts_thumbnail/$id', thumbnail);
      await _db.collection('posts').doc(id).set({
        'id': id,
        'title': title,
        'description': description,
        'thumbnail': imageUrl,
        'likes_count': 0,
        'bookmark_count': 0,
        'comments_count': 0,
        'badge_id': '',
        'createdAt': now,
        'updatedAt': now,
        'author_id': authorId,
        'category': category,
        'is_reported': false,
      });
    } catch (error) {
      print("Error adding post: $error");
    }
  }

  Future<String> uploadThumbnail(String fileName, Uint8List file) async {
    Reference ref = _storage.ref().child(fileName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> deletePost(String postId, String imageUrl) async {
    try {
      await _db.collection('posts').doc(postId).delete();
      await _storage.refFromURL(imageUrl).delete();
    } catch (error) {
      print("Error deleting post: $error");
    }
  }

  Future<void> reportPost(String postId) async {
    try {
      await _db.collection('posts').doc(postId).update({'is_reported': true});
    } catch (error) {
      print("Error reporting post: $error");
    }
  }

  Future<void> revertPost(String postId) async {
    try {
      await _db.collection('posts').doc(postId).update({'is_reported': false});
    } catch (error) {
      print("Error reverting post: $error");
    }
  }
}
