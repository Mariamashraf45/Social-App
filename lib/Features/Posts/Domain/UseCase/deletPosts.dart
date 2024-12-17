
import 'package:dartz/dartz.dart';
import 'package:fire/Features/Posts/Domain/Reposatories/post_repo.dart';
import 'package:fire/global/Errors/failures.dart';

class deletPostUseCase{
  final PostRepo repo;

  deletPostUseCase({required this.repo});
  Future<Either<Failures,Unit>> call(int PostId) async{
    return await repo.deleteposts(PostId);

  }
}