
import 'package:dartz/dartz.dart';
import 'package:fire/Features/Posts/Domain/Entities/post_entity.dart';
import 'package:fire/Features/Posts/Domain/Reposatories/post_repo.dart';
import 'package:fire/global/Errors/failures.dart';

class addPostUseCase{
  final PostRepo repo;

  addPostUseCase({required this.repo});
  Future<Either<Failures,Unit>> call(PostsEntity post) async{
    return await repo.addposts(post);
  }
}