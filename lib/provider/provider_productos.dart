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

  set imagenNueva(String value) {
    copydata.imagen = value;
    notifyListeners();
  }

  Future<String> nuevoProducto(Producto producto) async {
    String url = 'stock-5961c-default-rtdb.firebaseio.com';

    var uri = Uri.https(url, 'productos.json');

    http.Response response =
        await http.post(uri, body: producto.jsonProducto());

    //el response es el nombre del nuevo lugar, id..
    var nuevoid = jsonDecode(response.body);
    print(nuevoid);
    return nuevoid['name'];
  }

  Future<String> setbasedatos(Producto producto) async {
    const url = 'stock-5961c-default-rtdb.firebaseio.com';

    Uri uri = Uri.https(url, 'productos/${producto.id}.json');

    String jsonproduct = producto.jsonProducto();

    http.Response response = await http.put(uri, body: jsonproduct);

    var index = _listadoproductos.indexWhere((x) => x.id == producto.id);
    _listadoproductos[index] = producto;
    notifyListeners();
    return response.body;
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
  nuevoProductolistalocal(Producto producto) {
    _listadoproductos.add(producto);
    notifyListeners();
  }

  bool get estadoDisponibleCopy => copydata.disponible;
  set estadoDisponibleCopy(bool value) {
    copydata.disponible = value;
    notifyListeners();
  }

  Future<String?> enviarFoto(String ruta) async {
    if (ruta == null) {
      return null;
    }

    Uri url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dhmgzz9eq/image/upload?upload_preset=y1ikv3xf'); //hay que pegar de postman con el upload presset

    final imageload = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', ruta);
    imageload.files.add(file);

    final sttreamResponse = await imageload.send();
    final response = await http.Response.fromStream(sttreamResponse);
    final decode = jsonDecode(response.body);
    print(' response ${response.body}');
    //print(' streanResponse ${sttreamResponse.statusCode}');
    return decode['secure_url'];
  }
}
