import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:formulariologin/model/producto.dart';
import 'package:http/http.dart' as http;

class ProviderPreoductos extends ChangeNotifier {
  List<Producto> _listadoproductos = [];
  late Producto copydata;

  ProviderPreoductos() {
    getProductos();
  }

  Future<void> setbasedatos(List<Producto> listado) async {
    final List<Map<String, dynamic>> tem = [];
    listado.forEach((element) {
      tem.add(element.toMap());
    });
    print(' listado mapeado ${tem}');
  }

  Future<List<Producto>> getProductos() async {
    const url = 'stock-5961c-default-rtdb.firebaseio.com';

    Uri uri = Uri.https(url, 'productos.json');

    http.Response response = await http.get(uri);
    // print('RESPONSE  ${response.body}');

    Map<String, dynamic> temp = jsonDecode(response.body);
    // print('json --->  ${temp['abc23']['precio']}');

    temp.forEach((key, value) {
      Producto tempp = Producto.fromjson(value);
      tempp.id = key;

      _listadoproductos.add(tempp);

      //print(' KEY ${tempp.id}');
      // print('Value ${value}');
    });
    //print({'Listado de productos ${_listadoproductos[1].imagen}'});
    notifyListeners();
    return _listadoproductos;
  }

  List<Producto> get listarproducto => _listadoproductos;

  bool get estadoDisponibleCopy => copydata.disponible;
  set estadoDisponibleCopy(bool value) {
    copydata.disponible = value;
    notifyListeners();
  }
}
