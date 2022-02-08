import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:formulariologin/model/producto.dart';
import 'package:http/http.dart' as http;

class ProviderPreoductos extends ChangeNotifier {
  final List<Producto> listadoproductos = [];

  ProviderPreoductos() {
    getProductos();
  }

  Future<List<Producto>> getProductos() async {
    const url = 'stock-5961c-default-rtdb.firebaseio.com';

    Uri uri = Uri.https(url, 'productos.json');

    http.Response response = await http.get(uri);
    print('RESPONSE  ${response.body}');

    var temp = jsonDecode(response.body);
    print('json --->  ${temp['abc23']['precio']}');

    return listadoproductos;
  }
}
