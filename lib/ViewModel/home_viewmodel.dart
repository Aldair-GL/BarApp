import '../model/order.dart';
import '../model/product.dart';
/// ViewModel para la página principal.
class HomeViewModel {
  final List<Order> _orders = [
    Order(
      nombreMesa: "Mesa 1",
      productos: [
        Product(nombre: "Café", precio: 1.20, cantidad: 2),
        Product(nombre: "Tostada", precio: 1.50, cantidad: 1),
      ],
    ),
  ];
/// Obtiene la lista de órdenes.
  List<Order> get orders => _orders;
/// Agrega una nueva orden a la lista.
  void addOrder(Order order) {
    _orders.add(order);
  }
}
