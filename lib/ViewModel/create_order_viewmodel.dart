import '../model/product.dart';
import '../model/order.dart';

class CreateOrderViewModel {
  String tableName = "";
  List<Product> selectedProducts = [];

  double get total =>
      selectedProducts.fold(0, (sum, p) => sum + p.total);

  bool get isValid =>
      tableName.trim().isNotEmpty && selectedProducts.isNotEmpty;

  void updateTableName(String name) {
    tableName = name;
  }

  void updateProducts(List<Product> products) {
    selectedProducts = products;
  }

  Order buildOrder() {
    return Order(
      nombreMesa: tableName,
      productos: selectedProducts,
    );
  }
}
