part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class GetPostsEvent extends PostEvent {}

class GetPostEvent extends PostEvent {
  final int? id;

  GetPostEvent(this.id);
}
