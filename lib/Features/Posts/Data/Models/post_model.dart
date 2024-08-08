import 'package:fire/Features/Posts/Data/Models/post_model.dart';
import 'package:fire/Features/Posts/Domain/Entities/post_entity.dart';

class PostModel extends PostsEntity {
  PostModel(
      {required super.postId,
      required super.name,
      required super.uId,
      required super.profilePhoto,
      required super.postTime,
      required super.text,
      required super.imageUrl,
      required super.likes});

  factory PostModel.fromjson(Map<String, dynamic> json) {
    return PostModel(
        postId: json['postId'],
        name: json['name'],
        uId: json['uId'],
        profilePhoto: json['profilePhoto'],
        postTime: json['postTime'],
        text: json['text'],
        imageUrl: json['imageUrl'],
        likes: json['likes']);
  }

  Map<String, dynamic> tojson() {
    return {
      'postId': postId,
      'name': name,
      'uId': uId,
      'profilePhoto': profilePhoto,
      'postTime': postTime,
      'text': text,
      'imageUrl': imageUrl,
      'likes': likes
    };
  }
}
