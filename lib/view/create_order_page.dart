import 'package:flutter/material.dart';
import '../ViewModel/create_order_viewmodel.dart';
import 'product_selection_page.dart';

class CreateOrderPage extends StatefulWidget {
  @override
  _CreateOrderPageState createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  final viewModel = CreateOrderViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Crear Pedido")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Mesa o nombre"),
              onChanged: viewModel.updateTableName,
            ),
            SizedBox(height: 16),

            ElevatedButton(
              onPressed: () async {
                final products = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ProductSelectionPage()),
                );
                if (products != null) {
                  if (!mounted) return;
                  setState(() {
                    viewModel.updateProducts(products);
                  });
                }
              },
              child: Text("Añadir productos"),
            ),

            SizedBox(height: 16),
            Text("Productos seleccionados:",
                style: TextStyle(fontWeight: FontWeight.bold)),

            Expanded(
              child: ListView.builder(
                itemCount: viewModel.selectedProducts.length,
                itemBuilder: (_, i) {
                  final p = viewModel.selectedProducts[i];
                  return ListTile(
                    title: Text("${p.nombre} x${p.cantidad}"),
                    trailing:
                        Text("${p.total.toStringAsFixed(2)} €"),
                  );
                },
              ),
            ),

            Text("Total: ${viewModel.total.toStringAsFixed(2)} €",
                style: TextStyle(fontSize: 18)),

            SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/resumen',
                  arguments: viewModel.buildOrder(),
                );
              },
              child: Text("Ver resumen"),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancelar")),
                ElevatedButton(
                    onPressed: viewModel.isValid
                        ? () {
                            Navigator.pop(
                                context, viewModel.buildOrder());
                          }
                        : null,
                    child: Text("Guardar Pedido")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
