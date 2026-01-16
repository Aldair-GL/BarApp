import 'package:flutter/material.dart';
import '../ViewModel/home_viewmodel.dart';
import 'create_order_page.dart';
/// Página principal que muestra las órdenes.
class HomePage extends StatefulWidget {
  final HomeViewModel viewModel;
/// Constructor de la clase HomePage.
  HomePage({required this.viewModel});

  @override
  _HomePageState createState() => _HomePageState();
}
/// Estado de la página HomePage.
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pedidos del Bar")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newOrder = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CreateOrderPage()),
          );
/// Añade la nueva orden si se ha creado correctamente.
          if (newOrder != null) {
            if (!mounted) return;
            setState(() {
              widget.viewModel.addOrder(newOrder);
            });
          }
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: widget.viewModel.orders.length,
        itemBuilder: (_, i) {
          final order = widget.viewModel.orders[i];
          return ListTile(
            title: Text(order.nombreMesa),
            subtitle: Text("${order.totalItems} productos"),
            trailing: Text("${order.totalPrice.toStringAsFixed(2)} €"),
          );
        },
      ),
    );
  }
}
