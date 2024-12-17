import 'package:equatable/equatable.dart';

class PostsEntity extends Equatable {
  final String id;
  final String body;
  final String title;

  const PostsEntity({required this.id, required this.body, required this.title});
  @override
  List<Object?> get props => [id, body, title];
}
