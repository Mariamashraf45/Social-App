import 'package:dartz/dartz.dart';
import 'package:fire/Features/Posts/Data/DataSource/local_data.dart';
import 'package:fire/Features/Posts/Data/DataSource/remote_data.dart';
import 'package:fire/Features/Posts/Domain/Entities/post_entity.dart';
import 'package:fire/Features/Posts/Domain/Reposatories/post_repo.dart';
import 'package:fire/global/failures.dart';
import 'package:flutter/cupertino.dart';

class PostRepoImpl implements PostRepo{
  final PostsRemoteDataSource remoteDataSource;
  final PostLocalDataSource postLocalDataSource;

  PostRepoImpl(this.remoteDataSource, this.postLocalDataSource);

  @override
  Future<Either<Failures, Unit>> addposts(PostsEntity post) {
    throw Unit;
  }

  @override
  Future<Either<Failures, Unit>> deleteposts(int id) {
    // TODO: implement deleteposts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, List<PostsEntity>>> getallposts() {
    // TODO: implement getallposts
    throw UnimplementedError();
  }

}