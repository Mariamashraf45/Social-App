import 'package:equatable/equatable.dart';

class PostsEntity extends Equatable{

  final String postId;
  final String name;
  final String uId;
  final String profilePhoto;
  final String postTime;
  final String text;
  final String imageUrl;
  final int likes;

  PostsEntity({
    required this.postId,
    required this.name,
    required this.uId,
    required this.profilePhoto,
    required this.postTime,
    required this.text,
    required this.imageUrl,
    required this.likes,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [postId, name,uId,profilePhoto,postTime,text,imageUrl,likes];

}