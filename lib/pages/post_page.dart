import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/blocs/post_bloc/post_bloc.dart';

class PostPage extends StatefulWidget {
  const PostPage({
    super.key,
  });

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
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
      child: BlocBuilder<PostBloc, PostState>(builder: (context, state) {
        if (state is PostLoading || state is PostInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is PostByIdFinish) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    child: Text(
                      state.post.title ?? '',
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "/");
                    },
                  ),
                  Text(state.post.body ?? ''),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
