import 'package:fire/Features/Posts/Domain/Entities/post_entity.dart';

class PostModel extends PostsEntity {
  PostModel({required super.id, required super.body, required super.title});

  factory PostModel.fromjson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'].toString(),
      body: json['body'] as String,
      title: json['title'] as String,
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'id': id,
      'body': body,
      'title': title,
    };
  }
}
