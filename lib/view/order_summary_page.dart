import 'package:flutter/material.dart';
import '../model/order.dart';

class OrderSummaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Order order =
        ModalRoute.of(context)!.settings.arguments as Order;

    return Scaffold(
      appBar: AppBar(title: Text("Resumen del pedido")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Mesa: ${order.nombreMesa}",
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),

            Text("Productos:",
                style: TextStyle(fontWeight: FontWeight.bold)),

            Expanded(
              child: ListView.builder(
                itemCount: order.productos.length,
                itemBuilder: (_, i) {
                  final p = order.productos[i];
                  return ListTile(
                    title: Text("${p.nombre} x${p.cantidad}"),
                    trailing:
                        Text("${p.total.toStringAsFixed(2)} €"),
                  );
                },
              ),
            ),

            SizedBox(height: 16),
            Text(
              "Total: ${order.totalPrice.toStringAsFixed(2)} €",
              style: TextStyle(fontSize: 22),
            ),

            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Volver"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
