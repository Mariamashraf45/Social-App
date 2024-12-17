import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:fire/Features/Posts/Data/Models/post_model.dart';
import 'package:fire/global/Errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getAllCachedPost();
  Future<Unit> cachPost(List<PostModel> postModels);
}

class PostLocalDataSourceImpl implements PostLocalDataSource {
  final SharedPreferences sharedPreferencesd;

  PostLocalDataSourceImpl({required this.sharedPreferencesd});

  @override
  Future<List<PostModel>> getAllCachedPost() async {
    final jsonString = sharedPreferencesd.getString('Cached Post');
    if (jsonString != null) {
      List jsonDecodedData = json.decode(jsonString);
      List<PostModel> jsonToPostModel = jsonDecodedData
          .map<PostModel>((jsonPostModel) => PostModel.fromjson(jsonPostModel))
          .toList();
      return jsonToPostModel;
    }
    throw emptyCachExceptions;
  }

  @override
  Future<Unit> cachPost(List<PostModel> postModels) async {
    List<Map<String, dynamic>> postModelToJson =
    postModels.map((postModel) => postModel.tojson()).toList();
    await sharedPreferencesd.setString("Cached Post", json.encode(postModelToJson));
    return unit;
  }
}