import 'dart:convert' as convert;
import 'dart:io';

import 'package:carros_app/pages/api_response.dart';
import 'package:carros_app/pages/carros/carro.dart';
import 'package:carros_app/pages/carros/carro_dao.dart';
import 'package:carros_app/pages/carros/upload_api.dart';
import 'package:carros_app/pages/login/usuario.dart';
import 'package:carros_app/utils/http_helper.dart' as http;

class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {
    var url ='https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo';

    print("GET > $url");

    var response = await http.get(url);

    String json = response.body;

    List list = convert.json.decode(json);

    List<Carro> carros = list.map<Carro>((map) => Carro.fromMap(map)).toList();

    return carros;
  }

  static Future<ApiResponse<bool>> save(Carro c, File file) async {
    try {

      if(file != null){
        ApiResponse<String> response = await UploadApi.upload(file);
        if(response.ok){
          c.urlFoto = response.result;
        }
      }

      var url = 'https://carros-springboot.herokuapp.com/api/v2/carros';
      if (c.id != null) {
        url += "/${c.id}";
      }

      print("POST > $url");

      String json = c.toJson();

      print("   JSON > $json");

      var response = await (c.id == null
          ? http.post(url, body: json)
          : http.put(url, body: json));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map mapResponse = convert.json.decode(response.body);

        Carro carro = Carro.fromMap(mapResponse);

        print("Novo carro: ${carro.id}");

        return ApiResponse.ok(true);
      }

      if (response.body == null || response.body.isEmpty) {
        return ApiResponse.error("Não foi possível salvar o carro");
      }

      Map mapResponse = convert.json.decode(response.body);
      return ApiResponse.error(mapResponse["error"]);
    } catch (e) {
      print(e);

      return ApiResponse.error("Não foi possível salvar o carro");
    }
  }

  static Future<ApiResponse<bool>> delete(Carro c) async {
    try {

      var url = 'https://carros-springboot.herokuapp.com/api/v2/carros/${c.id}';

      print("DELETE > $url");

      var response = await http.delete(url);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return ApiResponse.ok(true);
      }

      return ApiResponse.error("Não foi possível deletar o carro");
    } catch (e) {
      print(e);

      return ApiResponse.error("Não foi possível deletar o carro");
    }
  }

  static Future<List<Carro>> search(String query) async {
    List<Carro> carros = await CarroDAO().search();
    List<Carro> list = List<Carro>();
    for(Carro c in carros){
      if(c.nome.toUpperCase().contains(query.toUpperCase())){
        list.add(c);
      }
    }

    return list;
  }
}
