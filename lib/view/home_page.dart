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
      appBar: AppBar(
        title: Text("Pedidos del Bar"),
        centerTitle: true,
      ),
      
      // TOOLTIP añadido al FloatingActionButton
      floatingActionButton: FloatingActionButton(
        tooltip: "Crear un nuevo pedido para una mesa", // Punto 3: Tooltip
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

            // PUNTO 3: SNACKBAR de confirmación
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("✅ Pedido para ${newOrder.nombreMesa} añadido a la lista"),
                backgroundColor: Colors.green.shade700,
                behavior: SnackBarBehavior.floating, // Hace que el snackbar flote
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        child: Icon(Icons.add),
      ),
      
      body: widget.viewModel.orders.isEmpty
          ? Center(child: Text("No hay pedidos activos"))
          : ListView.builder(
              itemCount: widget.viewModel.orders.length,
              itemBuilder: (_, i) {
                final order = widget.viewModel.orders[i];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(child: Icon(Icons.restaurant)),
                    title: Text(order.nombreMesa, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("${order.productos.length} productos registrados"),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("${order.totalPrice.toStringAsFixed(2)} €",
                            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("Pendiente", style: TextStyle(fontSize: 10, color: Colors.orange)),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}