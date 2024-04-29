import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:travelbuddy/models/post.dart';
import 'package:travelbuddy/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(
    String caption,
    String source,
    String destination,
    String date,
    String weight,
    String price,
    Uint8List img,
    String uid,
    String username,
    String profImage,
  ) async {
    String res = "Some error occured";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', img, true);

      String postId = const Uuid().v1();

      int w = int.tryParse(weight.replaceAll(RegExp(r'[^0-9]+'), '')) ?? 0;
      int p = int.tryParse(price.replaceAll(RegExp(r'[^0-9]+'), '')) ?? 0;
      DateTime now = DateTime.now();
      String datePublished = DateFormat('dd/MM/yyyy').format(now);

      Post post = Post(
        caption: caption,
        source: source,
        destination: destination,
        date: date,
        weight: w,
        price: p,
        photoUrl: photoUrl,
        uid: uid,
        username: username,
        datePublished: datePublished,
        postId: postId,
        likes: [],
        profImage: profImage,
      );

      _firestore.collection('posts').doc(postId).set(post.toJson());

      res = "success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  //delete the post
  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      print(e);
    }
  }
}
