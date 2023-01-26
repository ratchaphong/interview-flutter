part of 'post_bloc.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostError extends PostState {
  final String message;

  PostError(this.message);
}

class PostFinish extends PostState {
  final List<Post> posts;

  PostFinish(this.posts);
}
