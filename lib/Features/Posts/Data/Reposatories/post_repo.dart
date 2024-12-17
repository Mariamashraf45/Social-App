import 'package:dartz/dartz.dart';
import 'package:fire/Features/Posts/Data/DataSource/local_data.dart';
import 'package:fire/Features/Posts/Data/DataSource/remote_data.dart';
import 'package:fire/Features/Posts/Data/Models/post_model.dart';
import 'package:fire/Features/Posts/Domain/Entities/post_entity.dart';
import 'package:fire/Features/Posts/Domain/Reposatories/post_repo.dart';
import 'package:fire/global/Errors/exceptions.dart';
import 'package:fire/global/Errors/failures.dart';
import 'package:fire/global/network_info.dart';

class PostRepoImpl implements PostRepo {
  final PostsRemoteDataSource postRemoteDataSource;
  final PostLocalDataSource postLocalDataSource;
  final NetworkInfo networkInfo;

  PostRepoImpl(
      this.postRemoteDataSource, this.postLocalDataSource, this.networkInfo);

  @override
  Future<Either<Failures, Unit>> addposts(PostsEntity post) async {
    final PostModel postModel = PostModel(
      id: post.id,
      body: post.body,
      title: post.title,
    );
    return getFunction(() async {
      return await postRemoteDataSource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failures, Unit>> deleteposts(int id) async {
    return getFunction(() async {
      return await postRemoteDataSource.deletePost(id.toString());
    });
  }

  @override
  Future<Either<Failures, List<PostsEntity>>> getallposts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePost = await postRemoteDataSource.getAllPosts();
        // Await the Future before passing it to the cache
        await postLocalDataSource.cachPost(remotePost);
        return Right(remotePost);
      } on serverExceptions {
        return Left(serverFailure());
      }
    } else {
      try {
        final localPost = await postLocalDataSource.getAllCachedPost();
        return Right(localPost);
      } on emptyCachExceptions {
        return Left(emptyCachFailure());
      }
    }
  }

  Future<Either<Failures, Unit>> getFunction(
      Future<Unit> Function() deletOradd) async {
    if (await networkInfo.isConnected) {
      try {
        await deletOradd();
        return Right(unit); // Simply return unit
      } on serverExceptions {
        return Left(serverFailure());
      }
    } else {
      return Left(offlineFailure());
    }
  }
}
