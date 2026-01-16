/// Modelo que representa un producto en el sistema.
class Product {
  final String nombre;
  final double precio;
  int cantidad;

/// Constructor de la clase Product.
  Product({
    required this.nombre,
    required this.precio,
    this.cantidad = 1,
  });

  double get total => cantidad * precio;

/// Crea una copia del producto con una cantidad modificada.
  Product copyWith({int? cantidad}) {
    return Product(
      nombre: nombre,
      precio: precio,
      cantidad: cantidad ?? this.cantidad,
    );
  }
}
