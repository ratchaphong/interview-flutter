import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/blocs/post_bloc/post_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              child: const Text("Posts"),
              onTap: () {
                BlocProvider.of<PostBloc>(context).add(GetPostsEvent());
                Navigator.pushNamed(context, "/posts");
              },
            ),
            InkWell(
              child: const Text("Cocktail"),
              onTap: () {
                Navigator.pushNamed(context, "/cocktail");
              },
            ),
          ],
        ),
      ),
    );
  }
}
