import 'package:dartz/dartz.dart';
import 'package:fire/Features/Posts/Data/Models/post_model.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostModel>>getAllPost();
  Future<Unit>odeletPost();
  Future<Unit>dPost();
}
class PostRemoTeDataSourceImpl extends PostsRemoteDataSource{
  @override
  Future<Unit> dPost() {
    // TODO: implement dPost
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getAllPost() {
    // TODO: implement getAllPost
    throw UnimplementedError();
  }

  @override
  Future<Unit> odeletPost() {
    // TODO: implement odeletPost
    throw UnimplementedError();
  }

}