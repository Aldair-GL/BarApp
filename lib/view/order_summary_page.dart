import 'package:flutter/material.dart';
import '../model/order.dart';

/// Página que muestra el resumen de una orden.
class OrderSummaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Order order =
        ModalRoute.of(context)!.settings.arguments as Order;

    // Punto 3: Snackbar automático al cargar la página para dar feedback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Resumen generado para ${order.nombreMesa}"),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.blueGrey,
        ),
      );
    });

    /// Construye la interfaz de usuario de la página.
    return Scaffold(
      appBar: AppBar(
        title: Text("Resumen del pedido"),
        actions: [
          // Icono con Tooltip (Punto 3)
          IconButton(
            icon: Icon(Icons.print),
            tooltip: "Imprimir ticket para el cliente",
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Enviando a impresora...")),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Mesa: ${order.nombreMesa}",
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
            SizedBox(height: 20),

            /// Listado de productos en la orden.
            Text("Productos:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Divider(),

            Expanded(
              child: ListView.builder(
                itemCount: order.productos.length,
                itemBuilder: (_, i) {
                  final p = order.productos[i];
                  return ListTile(
                    leading: Icon(Icons.check_circle_outline, color: Colors.green),
                    title: Text("${p.nombre} x${p.cantidad}"),
                    trailing:
                        Text("${p.total.toStringAsFixed(2)} €", 
                        style: TextStyle(fontWeight: FontWeight.w500)),
                  );
                },
              ),
            ),

            /// Mostrar el total de la orden.
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total a pagar:", style: TextStyle(fontSize: 18)),
                  Text(
                    "${order.totalPrice.toStringAsFixed(2)} €",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green.shade700),
                  ),
                ],
              ),
            ),

            /// Botón para volver con TOOLTIP (Punto 3)
            Center(
              child: Tooltip(
                message: "Regresar a la pantalla de edición",
                child: ElevatedButton.icon(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                  label: Text("Volver"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 45),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}