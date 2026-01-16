import '../model/product.dart';
import '../model/order.dart';
/// ViewModel para crear una orden.
class CreateOrderViewModel {
  String tableName = "";
  List<Product> selectedProducts = [];
/// Calcula el precio total de los productos seleccionados.
  double get total =>
      selectedProducts.fold(0, (sum, p) => sum + p.total);
/// Verifica si la orden es válida.
  bool get isValid =>
      tableName.trim().isNotEmpty && selectedProducts.isNotEmpty;
/// Actualiza el nombre de la mesa o cliente.
  void updateTableName(String name) {
    tableName = name;
  }
/// Actualiza la lista de productos seleccionados.
  void updateProducts(List<Product> products) {
    selectedProducts = products;
  }
/// Construye la orden final.
  Order buildOrder() {
    return Order(
      nombreMesa: tableName,
      productos: selectedProducts,
    );
  }
}
