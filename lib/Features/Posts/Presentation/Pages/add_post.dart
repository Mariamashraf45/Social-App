import 'package:fire/Features/Posts/Presentation/Pages/post_page.dart';
import 'package:fire/Features/Posts/Presentation/Widets/Add_Del_posts/form_widget.dart';
import 'package:fire/Features/Posts/Presentation/bloc/AddDelete/add_del_bloc.dart';
import 'package:fire/Features/Posts/Presentation/bloc/AddDelete/add_del_state.dart';
import 'package:fire/global/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fire/global/util/snack_bar.dart';
class AddPost extends StatelessWidget {
  const AddPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: const Text(
          'Add Post',
          style: TextStyle(fontSize: 20),
        ),
      );

  Widget _buildBody() {
    return BlocConsumer<AddDelBloc, AddDelState>(builder: (context, state) {
      if (state is LoadingAddDeletPost) {
        return LoadingWidget();
      } else {
        return FormWidget();
      }
    }, listener: (context, state) {
      if (state is LoadedAddDeletPost) {
        ShowSnackBar().showSuccessSnackBar(state.message, context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => PostPage(),
          ),
          (route) => false,
        );
      } else if (state is ErrorAddDeletPost) {
        ShowSnackBar().showErrorSnackBar(state.message, context);
      }
    });
  }
}
