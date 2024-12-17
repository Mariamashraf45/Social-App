import 'package:equatable/equatable.dart';


abstract class AddDelState extends Equatable {
  const AddDelState();
  @override
  List<Object?> get props => [];
}

class IntialAddDeletPost extends AddDelState {}

class LoadingAddDeletPost extends AddDelState {}

class ErrorAddDeletPost extends AddDelState {
  final String message;

  ErrorAddDeletPost({required this.message});


  @override
  List<Object?> get props => [message];
}

class LoadedAddDeletPost extends AddDelState {
  final String message;

  LoadedAddDeletPost({required this.message});

  @override
  List<Object?> get props => [message];
}
