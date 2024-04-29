import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String caption;
  final String source;
  final String destination;
  final String date;
  final int weight;
  final int price;
  final String photoUrl;
  final String uid;
  final String username;
  final String datePublished;
  final String postId;
  final List likes;
  final String profImage;

  const Post({
    required this.caption,
    required this.source,
    required this.destination,
    required this.date,
    required this.weight,
    required this.price,
    required this.photoUrl,
    required this.uid,
    required this.username,
    required this.datePublished,
    required this.postId,
    required this.likes,
    required this.profImage,
  });

  Map<String, dynamic> toJson() => {
        "caption": caption,
        "source": source,
        "destination": destination,
        "date": date,
        "weight": weight,
        "price": price,
        "photoUrl": photoUrl,
        "uid": uid,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        "likes": likes,
        "profImage": profImage,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      caption: snapshot['caption'],
      source: snapshot['source'],
      photoUrl: snapshot['photoUrl'],
      destination: snapshot['destination'],
      date: snapshot['date'],
      weight: snapshot['weight'],
      price: snapshot['price'],
      uid: snapshot['uid'],
      username: snapshot['datePublished'],
      postId: snapshot['postId'],
      datePublished: snapshot['datePublished'],
      likes: snapshot['likes'],
      profImage: snapshot['profImage'],
    );
  }
}
