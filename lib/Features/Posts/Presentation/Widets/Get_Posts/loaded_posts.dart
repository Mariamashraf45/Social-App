import 'package:fire/Features/Posts/Domain/Entities/post_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadedPost extends StatelessWidget {
  final List<PostsEntity> posts;

  const LoadedPost({super.key, required this.posts});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(posts[index].id,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blueAccent)),
            title: Text(
              posts[index].title,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              posts[index].body,
              style: const TextStyle(fontSize: 18),
            ),
            onTap: () {}, //ToDo impl
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          );
        },
        separatorBuilder: (context, index) =>
            const Divider(thickness: 1, color: Colors.grey),
        itemCount: posts.length);
  }
}
