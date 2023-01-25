import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/models/cocktail_db/cocktail_db.dart';
import 'package:hello_flutter/pages/detail_page.dart';
import 'package:http/http.dart' as http;

class ListPageArgs {
  final String searchText;

  ListPageArgs(this.searchText);
}

class ListPage extends StatefulWidget {
  // final String searchText;

  const ListPage({
    super.key,
    // required this.searchText,
  });

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool loaded = false;
  CocktailDb cocktailDb = const CocktailDb();

  @override
  void initState() {
    super.initState();
    // loadData();
  }

  // void loadData() async {
  //   try {
  //     var url = Uri.https(
  //       'www.thecocktaildb.com',
  //       '/api/json/v1/1/search.php',
  //       {'s': widget.searchText},
  //     );
  //     var r = await http.get(url);
  //     if (r.statusCode != 200) {
  //       if (kDebugMode) {
  //         print('Error');
  //       }
  //     }
  //     setState(() {
  //       cocktailDb = CocktailDb.fromJson(r.body);
  //       if (kDebugMode) {
  //         print(cocktailDb);
  //       }
  //     });
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }
  // }

  void loadData(String searchText) async {
    try {
      var url = Uri.https(
        'www.thecocktaildb.com',
        '/api/json/v1/1/search.php',
        {'s': searchText},
      );
      var r = await http.get(url);
      if (r.statusCode != 200) {
        if (kDebugMode) {
          print('Error');
        }
      }
      setState(() {
        cocktailDb = CocktailDb.fromJson(r.body);
        if (kDebugMode) {
          print(cocktailDb);
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ListPageArgs;
    if (!loaded) {
      loadData(args.searchText);
    }

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: cocktailDb.drinks
                ?.map(
                  (e) => ListTile(
                    // leading: Image.network(e.strDrinkThumb ?? ''),
                    leading: e.strDrinkThumb != null
                        ? Image.network(e.strDrinkThumb!)
                        : null,
                    title: Text(e.strDrink ?? ''),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => DetailPage(drink: e),
                      //   ),
                      // );
                      Navigator.pushNamed(
                        context,
                        "/detail",
                        arguments: DetailPageArgs(e),
                      );
                    },
                  ),
                )
                .toList() ??
            [],
      ),
    );
  }
}
