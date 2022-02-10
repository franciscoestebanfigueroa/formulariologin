import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:formulariologin/model/producto.dart';
import 'package:http/http.dart' as http;

class ProviderPreoductos extends ChangeNotifier {
  List<Producto> _listadoproductos = [];
  Producto? _copydata;

  ProviderPreoductos() {
    getProductos();
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

  set copy(Producto pd) {
    _copydata = Producto(
      pd.nombre,
      pd.descripcion,
      pd.imagen,
      pd.disponible,
      pd.precio,
      pd.id,
    );
    notifyListeners();
    print(copy.id);
    print(copy.nombre);
    print(copy.descripcion);
    print(copy.imagen);
    print(copy.precio);
    print(copy.disponible);
  }

  Producto get copy => _copydata ?? _listadoproductos[0];
}
