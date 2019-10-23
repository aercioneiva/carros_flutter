import 'package:carros_app/utils/event.dart';

class CarroEvent extends Event{
  String acao;
  String tipo;
  
  CarroEvent(this.acao,this.tipo);
}