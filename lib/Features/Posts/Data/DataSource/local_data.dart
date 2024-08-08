import 'package:dartz/dartz.dart';
import 'package:fire/Features/Posts/Data/Models/post_model.dart';

abstract class PostLocalDataSource{
 Future<List<PostModel>> getAllCachedPost();
Future<Unit> cachPost( Future<List<PostModel>>postModels);
}

class PostLocalDataSourceImpl extends PostLocalDataSource{
  @override
  Future<Unit> cachPost(Future<List<PostModel>> postModels) {
    // TODO: implement cachPost
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getAllCachedPost() {
    // TODO: implement getAllCachedPost
    throw UnimplementedError();
  }
  
}