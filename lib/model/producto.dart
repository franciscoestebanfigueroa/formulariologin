import 'dart:convert';

class Producto {
  String nombre;
  String? descripcion;
  String? imagen;
  bool disponible;
  double precio;
  String? id;

  Producto({
    required this.nombre,
    required this.descripcion,
    this.imagen,
    required this.disponible,
    required this.precio,
    this.id,
  });

  Producto.fromjson(Map<String, dynamic> json)
      : nombre = json['nombre'],
        descripcion = json['descripcion'],
        precio = json['precio'],
        disponible = json['disponible'],
        imagen = json['imagen'];

  Map<String, dynamic> toMap() => {
        'nombre': nombre,
        'disponible': disponible,
        'precio': precio,
        'imagen': imagen,
        'descripcion': descripcion
      };

  String jsonProducto() => jsonEncode(toMap());

  Producto copy() {
    return Producto(
      nombre: nombre,
      descripcion: descripcion,
      imagen: imagen,
      disponible: disponible,
      precio: precio,
      id: id,
    );
  }
}



//{
//    "asset_id": "6e529af803e39621b3cdb5deb5bbc97c",
//    "public_id": "dzysksqbj5wt3n7w0em7",
//    "version": 1644805390,
//    "version_id": "e4afd662706662a043f32adbaf856f36",
//    "signature": "f12845c69e585ef767891c1e7b9866eec56b4a22",
//    "width": 1920,
//    "height": 1080,
//    "format": "png",
//    "resource_type": "image",
//    "created_at": "2022-02-14T02:23:10Z",
//    "tags": [],
//    "bytes": 449530,
//    "type": "upload",
//    "etag": "8019a5f5ce9139e19589cbf3c0dee9aa",
//    "placeholder": false,
//    "url": "http://res.cloudinary.com/dhmgzz9eq/image/upload/v1644805390/dzysksqbj5wt3n7w0em7.png",
//    "secure_url": "https://res.cloudinary.com/dhmgzz9eq/image/upload/v1644805390/dzysksqbj5wt3n7w0em7.png",
//    "access_mode": "public",
//    "original_filename": "relieve"
//}