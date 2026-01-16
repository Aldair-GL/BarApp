import 'product.dart';

/// Modelo que representa una orden en el sistema.
class Order {
  final String nombreMesa;
  final List<Product> productos;

/// Constructor de la clase Order.
  Order({
    required this.nombreMesa,
    required this.productos,
  });

/// Calcula el precio total de la orden.
  double get totalPrice =>
      productos.fold(0, (sum, p) => sum + p.total);

  int get totalItems =>
      productos.fold(0, (sum, p) => sum + p.cantidad);
}
