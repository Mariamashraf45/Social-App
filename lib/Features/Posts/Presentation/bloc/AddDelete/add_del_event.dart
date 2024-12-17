import 'package:equatable/equatable.dart';
import 'package:fire/Features/Posts/Domain/Entities/post_entity.dart';

abstract class AddDelEvent extends Equatable {
  const AddDelEvent();
  @override
  List<Object?> get props => [];
}

class AddPostEvent extends AddDelEvent {
  final PostsEntity posts;

  AddPostEvent({required this.posts});
  @override
  List<Object?> get props => [posts];
}

class DeletePostEvent extends AddDelEvent {
  final int postId;

  DeletePostEvent({required this.postId});
  @override
  List<Object?> get props => [postId];
}
