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

  Producto copy() {
    print(id);
    return Producto(
      nombre: this.nombre,
      descripcion: this.descripcion,
      imagen: this.imagen,
      disponible: this.disponible,
      precio: this.precio,
      id: this.id,
    );
  }
}
