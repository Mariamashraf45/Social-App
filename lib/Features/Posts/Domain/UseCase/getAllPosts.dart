
import 'package:dartz/dartz.dart';
import 'package:fire/Features/Posts/Domain/Entities/post_entity.dart';
import 'package:fire/Features/Posts/Domain/Reposatories/post_repo.dart';
import 'package:fire/global/Errors/failures.dart';

class GetallpostsUseCase{
  final PostRepo repo;

  GetallpostsUseCase({required this.repo});
  Future<Either<Failures,List<PostsEntity>>> call() async{
    return await repo.getallposts();
  }
}