import 'package:flutter/material.dart';
import 'package:hello_flutter/models/cocktail_db/drink.dart';

class DetailPageArgs {
  final Drink drink;

  DetailPageArgs(this.drink);
}

class DetailPage extends StatefulWidget {
  // final Drink drink;
  const DetailPage({
    super.key,
    // required this.drink,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DetailPageArgs;
    final drink = args.drink;

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          // Text(widget.drink.strDrink ?? 'Nemesis'),
          // Image.network(widget.drink.strDrinkThumb ??
          //     'https://www.thecocktaildb.com/images/logo.png'),
          Text(drink.strDrink ?? 'Nemesis'),
          Image.network(drink.strDrinkThumb ??
              'https://www.thecocktaildb.com/images/logo.png'),
        ],
      ),
    );
  }
}
