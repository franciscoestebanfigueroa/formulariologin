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
