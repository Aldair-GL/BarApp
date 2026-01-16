import 'package:flutter/material.dart';
import '../ViewModel/home_viewmodel.dart';
import 'create_order_page.dart';

class HomePage extends StatefulWidget {
  final HomeViewModel viewModel;

  HomePage({required this.viewModel});

  @override
  _HomePageState createState() => _HomePageState();
}

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
