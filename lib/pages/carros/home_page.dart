import 'package:carros_app/drawer_list.dart';
import 'package:carros_app/pages/carros/carro.dart';
import 'package:carros_app/pages/carros/carro_form_page.dart';
import 'package:carros_app/pages/carros/carros_api.dart';
import 'package:carros_app/pages/carros/carros_page.dart';
import 'package:carros_app/pages/carros/carros_search.dart';
import 'package:carros_app/pages/favoritos/favoritos_page.dart';
import 'package:carros_app/utils/alert.dart';
import 'package:carros_app/utils/nav.dart';
import 'package:carros_app/utils/prefs.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _initTabs();
  }

  _initTabs() async {
    _tabController = TabController(length: 4, vsync: this);

    _tabController.index = await Prefs.getInt("tabIdx");

    _tabController.addListener(() {
      Prefs.setInt("tabIdx", _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _onClickSearch,
          ),
        ],
        title: Text("Carros"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: "Clássicos",
              icon: Icon(Icons.directions_car),
            ),
            Tab(
              text: "Esportivos",
              icon: Icon(Icons.directions_car),
            ),
            Tab(
              text: "Luxo",
              icon: Icon(Icons.directions_car),
            ),
            Tab(
              text: "Favoritos",
              icon: Icon(Icons.favorite),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CarrosPage(TipoCarro.classicos),
          CarrosPage(TipoCarro.esportivos),
          CarrosPage(TipoCarro.luxo),
          FavoritosPage(),
        ],
      ),
      drawer: DrawerList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _onClickAdicionarCarro,
      ),
    );
  }

  void _onClickAdicionarCarro() {
    push(context, CarroFormPage());
  }

  void _onClickSearch() async{
    final carro = await showSearch<Carro>(context: context,delegate: CarrosSearch());
    if(carro != null){
      alert(context,carro.nome);
    }
  }
}
