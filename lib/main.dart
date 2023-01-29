import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/blocs/cocktail_bloc/cocktail_bloc.dart';
import 'package:hello_flutter/blocs/post_bloc/post_bloc.dart';
import 'package:hello_flutter/pages/home_page.dart';
import 'package:hello_flutter/pages/post_page.dart';
import 'package:hello_flutter/pages/posts_page.dart';
import 'package:hello_flutter/repository/cocktail_repository.dart';
import 'package:hello_flutter/repository/post_repository.dart';
import 'package:hello_flutter/repository/the_cocktail_db_provider.dart';
import 'package:hello_flutter/pages/detail_page.dart';
import 'package:hello_flutter/pages/list_page.dart';
import 'package:hello_flutter/pages/search_page.dart';
import 'package:hello_flutter/repository/the_post_db_provider.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CocktailBloc>(
            create: (context) =>
                CocktailBloc(CocktailRepository(TheCocktailDbProvider()))),
        BlocProvider<PostBloc>(
            create: (context) => PostBloc(PostRepository(ThePostDbProvider()))),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/cocktail': (context) => const SearchPage(),
          '/list': (context) => const ListPage(),
          '/detail': (context) => const DetailPage(),
          '/posts': (context) => const PostsPage(),
          '/post': (context) => const PostPage(),
        },
      ),
    ),
  );
}

// flutter create hello_flutter
// flutter pub add bloc
// flutter pub add flutter_bloc
// https://www.thecocktaildb.com/api.php
// extension json To Dart Model ->  https://javiercbk.github.io/json_to_dart/
// extension bloc
// flutter pub add http
// flutter run
