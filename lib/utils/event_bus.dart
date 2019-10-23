import 'dart:async';

import 'package:carros_app/utils/event.dart';

class EventBus {
  StreamController _streamController = StreamController<Event>.broadcast();

  Stream<Event> get stream => _streamController.stream;

  void sendEvent(Event event){
    _streamController.add(event);
  }

  void dispose(){
    _streamController.close();
  }
}