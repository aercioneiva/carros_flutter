import 'dart:async';

import 'package:carros_app/pages/carros/carro.dart';
import 'package:carros_app/pages/carros/carro_event.dart';
import 'package:carros_app/pages/carros/carros_bloc.dart';
import 'package:carros_app/pages/carros/carros_listview.dart';
import 'package:carros_app/utils/event.dart';
import 'package:carros_app/utils/event_bus.dart';
import 'package:carros_app/widgets/text_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarrosPage extends StatefulWidget {
  String tipo;

  CarrosPage(this.tipo);

  @override
  _CarrosPageState createState() => _CarrosPageState();
}

class _CarrosPageState extends State<CarrosPage>
    with AutomaticKeepAliveClientMixin<CarrosPage> {

  List<Carro> carros;
  StreamSubscription<Event> subscription;
  String get tipo => widget.tipo;
  ScrollController _scrollController = ScrollController();

  final _bloc = CarrosBloc();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _bloc.fetch(tipo);

    EventBus bus = Provider.of<EventBus>(context, listen: false);
    subscription = bus.stream.listen((Event e){
      CarroEvent event = e;
      if(event.tipo == tipo){
        _bloc.fetch(tipo);
      }
      print("Event $e");
      
    });

    _scrollController.addListener((){
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        print("fim da lista");
         _bloc.fetchMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final List<Carro> list = [];

    return StreamBuilder(
      stream: _bloc.stream,
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
        list.addAll(carros);

        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: CarrosListView(list,scrollController: _scrollController,),
        );
      },
    );
  }

  Future<void> _onRefresh() {
    return _bloc.fetch(tipo);
  }

  @override
  void dispose() {
    super.dispose();

    _bloc.dispose();
    subscription.cancel();
  }
}
