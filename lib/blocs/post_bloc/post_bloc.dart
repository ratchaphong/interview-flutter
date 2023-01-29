import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:hello_flutter/models/post_db/post.dart';
import 'package:hello_flutter/repository/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;

  PostBloc(this.repository) : super(PostInitial()) {
    on<GetPostsEvent>((event, emit) async {
      // ignore: todo
      // TODO: implement event handler
      emit(PostLoading());
      try {
        var posts = await repository.getPosts();
        emit(PostFinish(posts));
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        emit(PostError(e.toString()));
      }
    });

    on<GetPostEvent>((event, emit) async {
      emit(PostLoading());
      try {
        var post = await repository.getPost(event.id);
        emit(PostByIdFinish(post!));
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        emit(PostError(e.toString()));
      }
    });
  }
}
