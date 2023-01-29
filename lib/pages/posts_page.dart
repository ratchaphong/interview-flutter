import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/blocs/post_bloc/post_bloc.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({
    super.key,
  });

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) async {
        if (state is PostError) {
          if (kDebugMode) {
            print(state.message);
          }
        }
      },
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading || state is PostInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PostFinish) {
            return Scaffold(
              appBar: AppBar(),
              body: ListView(
                children: state.posts
                    .map(
                      (e) => ListTile(
                        title: Text(e.title ?? ''),
                        subtitle: Text(e.body ?? ''),
                        onTap: () {
                          if (e.id != null) {
                            BlocProvider.of<PostBloc>(context)
                                .add(GetPostEvent(e.id));
                            Navigator.pushNamed(context, "/post");
                          }
                        },
                      ),
                    )
                    .toList(),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
