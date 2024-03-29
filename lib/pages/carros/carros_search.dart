import 'package:carros_app/pages/carros/carro.dart';
import 'package:carros_app/pages/carros/carros_api.dart';
import 'package:carros_app/pages/carros/carros_listview.dart';
import 'package:flutter/material.dart';

class CarrosSearch extends SearchDelegate<Carro> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length > 3) {
      // TODO: implement buildSuggestions
      return FutureBuilder(
        future: CarrosApi.search(query),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Carro> carros = snapshot.data;
            return CarrosListView(carros);
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }

    return Container();
  }
}
