
import 'package:carros_app/pages/favoritos/favorito.dart';
import 'package:carros_app/utils/sql/base_dao.dart';

class FavoritoDAO extends BaseDAO<Favorito> {

  @override
  Favorito fromMap(Map<String, dynamic> map) {
    return Favorito.fromMap(map);
  }

  @override
  String get tableName => "favorito";
}