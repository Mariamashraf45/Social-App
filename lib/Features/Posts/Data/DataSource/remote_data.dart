import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:fire/Features/Posts/Data/Models/post_model.dart';
import 'package:fire/global/Errors/exceptions.dart';
import 'package:http/http.dart' as http;

abstract class PostsRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePost(String postId);
  Future<Unit> addPost(PostModel post);
}

const Base_Url = 'https://jsonplaceholder.typicode.com';

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  final http.Client client;

  PostsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(Uri.parse('$Base_Url/posts'),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<PostModel> postModels = decodedJson
          .map<PostModel>((jsonPostModel) => PostModel.fromjson(jsonPostModel))
          .toList();
      return postModels;
    } else {
      throw serverExceptions();
    }
  }

  @override
  Future<Unit> addPost(PostModel post) async {
    final body = {
      'title': post.title,
      'body': post.body,
    };

    final response = await client.post(Uri.parse('$Base_Url/posts/'),
        body: json.encode(body),
        headers: {"Content-Type": "application/json"}
    );

    if (response.statusCode == 201) {
      return unit;
    } else {
      throw serverExceptions();
    }
  }

  @override
  Future<Unit> deletePost(String postId) async {
    final response = await client.delete(
        Uri.parse('$Base_Url/posts/$postId'),
        headers: {"Content-Type": "application/json"}
    );

    if (response.statusCode == 200) {
      return unit;
    } else {
      throw serverExceptions();
    }
  }
}
