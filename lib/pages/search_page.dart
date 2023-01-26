import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/bloc/cocktail_bloc.dart';
import 'package:hello_flutter/pages/list_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var textCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textCtrl,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  textCtrl.clear();
                },
              ),
            ],
          ),
          ElevatedButton(
            child: const Text('Search'),
            onPressed: () {
              // setState(() {
              //   textCtrl.text = 'Mojito';
              // });
              if (kDebugMode) {
                print(textCtrl.text);
              }
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ListPage(searchText: textCtrl.text),
              //   ),
              // );
              BlocProvider.of<CocktailBloc>(context)
                  .add(SearchEvent(textCtrl.text));
              Navigator.pushNamed(
                context,
                "/list",
              );
            },
          )
        ],
      ),
    );
  }
}
