import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:fire/Features/Posts/Domain/UseCase/addPosts.dart';
import 'package:fire/Features/Posts/Domain/UseCase/deletPosts.dart';
import 'package:fire/Features/Posts/Presentation/bloc/AddDelete/add_del_event.dart';
import 'package:fire/Features/Posts/Presentation/bloc/AddDelete/add_del_state.dart';
import 'package:fire/global/Errors/failures.dart';
import 'package:fire/global/strings/strings_failure.dart';
import 'package:fire/global/strings/strings_message.dart';


class AddDelBloc extends Bloc<AddDelEvent, AddDelState> {
  final addPostUseCase addPost;
  final deletPostUseCase deletPost;
  AddDelBloc(this.addPost, this.deletPost) : super(IntialAddDeletPost()) {
    on<AddDelEvent>(event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeletPost());
        final failureOrMessage = await addPost(event.posts);

        emit(ErrorOrMessage(failureOrMessage, addSucessMessage));
      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeletPost());
        final failureOrMessage = await deletPost(event.postId);

        emit(ErrorOrMessage(failureOrMessage, delSucessMessage));
      }
    }
  }
  AddDelState ErrorOrMessage(Either<Failures, Unit> either, String message) {
    return either.fold((failure) {
      return ErrorAddDeletPost(message: failureMessage(failure));
    }, (_) {
      return LoadedAddDeletPost(message: message);
    });
  }

  String failureMessage(Failures failure) {
    switch (failure.runtimeType) {
      case serverFailure:
        return serverFailureMassage;
      case offlineFailure:
        return offlineFailureMassage;
      case emptyCachFailure:
        return emptyCachFailureMassage;
      default:
        return "Unexpected Error. Please Try Again Later.";
    }
  }
}
