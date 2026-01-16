import 'product.dart';

class Order {
  final String nombreMesa;
  final List<Product> productos;

  Order({
    required this.nombreMesa,
    required this.productos,
  });

  double get totalPrice =>
      productos.fold(0, (sum, p) => sum + p.total);

  int get totalItems =>
      productos.fold(0, (sum, p) => sum + p.cantidad);
}
