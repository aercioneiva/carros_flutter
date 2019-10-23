import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros_app/pages/carros/carro.dart';
import 'package:carros_app/pages/carros/carro_page.dart';
import 'package:carros_app/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class CarrosListView extends StatelessWidget {
  List<Carro> carros;
  ScrollController scrollController;
  CarrosListView(this.carros,{this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        controller: scrollController,
        itemCount: carros.length + 1,
        itemBuilder: (context, index) {
          if(carros.length == index){
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
              ],
            );
          }
          Carro c = carros[index];
          return Container(
            height: 280,
            child: InkWell(
              onLongPress: () {
                _onLongClickCarro(context, c);
              },
              onTap: () {
                _onClickCarro(context, c);
              },
              child: Card(
                color: Colors.grey[100],
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: CachedNetworkImage(
                          imageUrl: c.urlFoto ??
                              "http://www.livroandroid.com.br/livro/carros/esportivos/Ferrari_FF.png",
                          width: 250,
                        ),
                      ),
                      Text(
                        c.nome,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        "descrição...",
                        style: TextStyle(fontSize: 16),
                      ),
                      ButtonTheme.bar(
                        // make buttons use the appropriate styles for cards
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('DETALHES'),
                              onPressed: () => _onClickCarro(context, c),
                            ),
                            FlatButton(
                              child: const Text('SHARE'),
                              onPressed: () {
                                _onClickShare(context, c);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _onClickCarro(context, Carro c) {
    push(context, CarroPage(c));
  }

  void _onLongClickCarro(BuildContext context, Carro c) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text(c.nome),
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.directions_car),
                title: Text("Detalhes"),
                onTap: () {
                  pop(context);
                  _onClickCarro(context, c);
                },
              ),
              ListTile(
                leading: Icon(Icons.share),
                  title: Text("Share"),
                  onTap: () {
                    pop(context);
                    _onClickShare(context, c);
                  }),
            ],
          );
        });
  }

  void _onClickShare(BuildContext context, Carro c) {
    Share.share(c.urlFoto);
  }
}
