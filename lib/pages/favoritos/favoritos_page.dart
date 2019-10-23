
import 'package:carros_app/pages/carros/carro.dart';
import 'package:carros_app/pages/carros/carros_listview.dart';
import 'package:carros_app/pages/favoritos/favoritos_bloc.dart';
import 'package:carros_app/widgets/text_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {


  @override
  bool get wantKeepAlive => true;
  FavoritosBloc get favoritosBloc => Provider.of<FavoritosBloc>(context, listen: false);

  @override
  void initState() {
    super.initState();
    favoritosBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: favoritosBloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return TextError("Não foi possível buscar os carros");
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Carro> carros = snapshot.data;

        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: CarrosListView(carros),
        );
      },
    );
  }

  Future<void> _onRefresh() {
    return favoritosBloc.fetch();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
