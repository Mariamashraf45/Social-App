
import 'package:fire/Features/Posts/Domain/Entities/post_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:fire/global/Errors/failures.dart';
abstract class PostRepo {
  Future<Either<Failures,List<PostsEntity>>> getallposts();
  Future<Either<Failures,Unit>> deleteposts(int id);
  Future<Either<Failures,Unit>> addposts(PostsEntity post);
}