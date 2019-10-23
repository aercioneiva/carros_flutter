
import 'dart:async';

import 'package:carros_app/pages/api_response.dart';
import 'package:carros_app/pages/login/login_api.dart';
import 'package:carros_app/pages/login/usuario.dart';

class LoginBloc {
  final _streamController = StreamController<bool>();

  get stream => _streamController.stream;

  Future<ApiResponse<Usuario>> login(String login, String senha) async {

    _streamController.add(true);

    ApiResponse response = await LoginApi.login(login, senha);

    _streamController.add(false);

    return response;
  }

  void dispose() {
    _streamController.close();
  }
}