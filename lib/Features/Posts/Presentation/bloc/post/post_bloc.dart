import 'package:bloc/bloc.dart';
import 'package:fire/Features/Posts/Domain/UseCase/getAllPosts.dart';
import 'package:fire/Features/Posts/Presentation/bloc/post/post_event.dart';
import 'package:fire/Features/Posts/Presentation/bloc/post/post_status.dart';
import 'package:fire/global/Errors/failures.dart';
import 'package:fire/global/strings/strings_failure.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetallpostsUseCase getallpostsUseCase;
  PostBloc(this.getallpostsUseCase) : super(PostIntialState()) {
    on<PostEvent>((event, emit) async {
      if (event is GetAllPostEvent || event is RefrechPostEvent) {
        emit(PostLoadingState());
        final post = await getallpostsUseCase();
        post.fold((failure) {
          emit(ErrorPostState(message: failureMessage(failure)));
        }, (posts) {
          emit(PostLoadedState(posts: posts));
        });
      }
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
