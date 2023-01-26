import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/blocs/cocktail_bloc/cocktail_bloc.dart';
import 'package:hello_flutter/models/cocktail_db/cocktail_db.dart';
import 'package:hello_flutter/models/cocktail_db/drink.dart';
import 'package:hello_flutter/pages/detail_page.dart';
import 'package:http/http.dart' as http;

class ListPage extends StatefulWidget {
  const ListPage({
    super.key,
  });

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CocktailBloc, CocktailState>(
      listener: (context, state) async {
        // ignore: todo
        // TODO: implement listener
        if (state is CocktailError) {
          if (kDebugMode) {
            print(state.message);
          }
          await _showMyDialog(context, state.message);
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<CocktailBloc, CocktailState>(
        builder: (context, state) {
          if (state is CocktailLoading || state is CocktailInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CocktailFinish) {
            return Scaffold(
              appBar: AppBar(
                actions: [DropDownFilter(drinks: state.drinks)],
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: state.drinks
                          .map(
                            (e) => ListTile(
                              leading: e.strDrinkThumb != null
                                  ? Image.network(e.strDrinkThumb!)
                                  : null,
                              title: Text(e.strDrink ?? ''),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  "/detail",
                                  arguments: DetailPageArgs(e),
                                );
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const Text("order"),
                ],
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

Future<void> _showMyDialog(BuildContext context, String message) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class DropDownFilter extends StatefulWidget {
  final List<Drink> drinks;
  const DropDownFilter({super.key, required this.drinks});

  @override
  State<DropDownFilter> createState() => _DropDownFilterState();
}

class _DropDownFilterState extends State<DropDownFilter> {
  // late List<String?> categories;
  late List<String?> categories = [null];

  String? selectedFilter;

  @override
  void initState() {
    super.initState();
    // categories = widget.drinks.map((e) => e.strCategory).toSet().toList();
    categories.addAll(widget.drinks.map((e) => e.strCategory).toSet().toList());
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String?>(
      value: selectedFilter,
      items: categories
          .map((e) => DropdownMenuItem(value: e, child: Text(e ?? 'All')))
          .toList(),
      onChanged: (selected) {
        BlocProvider.of<CocktailBloc>(context).add(FilterEvent(selected));
        setState(() {
          selectedFilter = selected;
        });
      },
    );
  }
}
