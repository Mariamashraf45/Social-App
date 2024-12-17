import 'package:equatable/equatable.dart';
import 'package:fire/Features/Posts/Domain/Entities/post_entity.dart';

abstract class PostState extends Equatable {
  const PostState();
  @override
  List<Object?> get props => [];
}

class PostIntialState extends PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  final List<PostsEntity> posts;
  PostLoadedState({required this.posts});
  @override
  List<Object?> get props => [posts];
}

class ErrorPostState extends PostState {
  final String message;

  ErrorPostState({required this.message});
  @override
  List<Object?> get props => [message];
}
