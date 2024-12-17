import 'package:fire/Features/Posts/Presentation/Pages/add_post.dart';
import 'package:fire/Features/Posts/Presentation/Widets/Get_Posts/Error_display_post.dart';
import 'package:fire/Features/Posts/Presentation/Widets/Get_Posts/loaded_posts.dart';
import 'package:fire/Features/Posts/Presentation/bloc/post/post_bloc.dart';
import 'package:fire/Features/Posts/Presentation/bloc/post/post_status.dart';
import 'package:fire/global/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      floatingActionButton: buildActionBtn(context),
    );
  }


  AppBar buildAppBar() => AppBar(
        title: const Text('Posts'),
      );

  Widget buildBody() {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoadingState) {
              return const LoadingWidget();
            } else if (state is PostLoadedState) return LoadedPost(posts: state.posts);

           else if(state is ErrorPostState) return ErrorDisplayPost(message: state.message);
          return const LoadingWidget();
           },

        ));
  }

Widget  buildActionBtn(BuildContext context) {
    return FloatingActionButton(onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => AddPost(),));
    },child: const Icon(Icons.add),);
}
}
