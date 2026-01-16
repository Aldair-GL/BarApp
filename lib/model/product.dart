class Product {
  final String nombre;
  final double precio;
  int cantidad;

  Product({
    required this.nombre,
    required this.precio,
    this.cantidad = 1,
  });

  double get total => cantidad * precio;

  Product copyWith({int? cantidad}) {
    return Product(
      nombre: nombre,
      precio: precio,
      cantidad: cantidad ?? this.cantidad,
    );
  }
}
