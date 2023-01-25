import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
          TextField(
            controller: textCtrl,
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
              Navigator.pushNamed(
                context,
                "/list",
                arguments: ListPageArgs(textCtrl.text),
              );
            },
          )
        ],
      ),
    );
  }
}
