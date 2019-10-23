import 'package:carros_app/pages/carros/carro.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatelessWidget {
  Carro carro;
  MapaPage(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro.nome),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: carro.latLng(),
          zoom: 17,
        ),
        markers: Set.of(_getMarkers()),
      ),
    );
  }

  List<Marker> _getMarkers() {
    return [
      Marker(
        markerId: MarkerId("1"),
        position: carro.latLng(),
        infoWindow: InfoWindow(
          title: carro.nome,
          snippet: "Aqui vai o snippet"
        ),
      ),
    ];
  }
}
