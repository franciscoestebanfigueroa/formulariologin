class Producto {
  final String nombre;
  final String? descripcion;
  String? imagen;
  final bool disponible;
  final double precio;
  late String id;

  Producto(
    this.nombre,
    this.descripcion,
    this.imagen,
    this.disponible,
    this.precio,
    this.id,
  );

  Producto.fromjson(Map<String, dynamic> json)
      : nombre = json['nombre'],
        descripcion = json['descripcion'],
        precio = json['precio'],
        disponible = json['disponible'],
        imagen = json['imagen'];
}
