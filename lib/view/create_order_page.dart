import 'package:flutter/material.dart';
import '../ViewModel/create_order_viewmodel.dart';
import 'product_selection_page.dart';

/// Página para crear una nueva orden.
class CreateOrderPage extends StatefulWidget {
  @override
  _CreateOrderPageState createState() => _CreateOrderPageState();
}

/// Estado de la página CreateOrderPage.
class _CreateOrderPageState extends State<CreateOrderPage> {
  final viewModel = CreateOrderViewModel();

  /// Construye la interfaz de usuario de la página.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Crear Pedido")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Mesa o nombre",
                helperText: "Ejemplo: Mesa 5 o Terraza", // Validación visual
              ),
              onChanged: (value) {
                setState(() {
                  viewModel.updateTableName(value);
                });
              },
            ),
            SizedBox(height: 16),

            /// Botón para añadir productos con TOOLTIP
            Tooltip(
              message: "Abrir el catálogo de productos",
              child: ElevatedButton.icon(
                icon: Icon(Icons.add_shopping_cart),
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
                    
                    // SNACKBAR informativo al añadir productos
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Productos actualizados correctamente"),
                        duration: Duration(seconds: 1),
                        backgroundColor: Colors.blueAccent,
                      ),
                    );
                  }
                },
                label: Text("Añadir productos"),
              ),
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
                    trailing: Text("${p.total.toStringAsFixed(2)} €"),
                  );
                },
              ),
            ),

            Divider(),
            Text("Total: ${viewModel.total.toStringAsFixed(2)} €",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),

            SizedBox(height: 16),

            /// Botón Resumen con TOOLTIP
            Tooltip(
              message: "Ver desglose detallado antes de guardar",
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade100),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/resumen',
                    arguments: viewModel.buildOrder(),
                  );
                },
                child: Text("Ver resumen", style: TextStyle(color: Colors.black)),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancelar")),

                /// Botón Guardar con TOOLTIP y lógica de SNACKBAR
                Tooltip(
                  message: viewModel.isValid ? "Finalizar y guardar pedido" : "Asigna una mesa y productos primero",
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: viewModel.isValid ? Colors.green : Colors.grey,
                      ),
                      onPressed: viewModel.isValid
                          ? () {
                              // Mostramos Snackbar de éxito antes de salir
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("✅ Pedido guardado con éxito"),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Navigator.pop(context, viewModel.buildOrder());
                            }
                          : null, 
                      child: Text("Guardar Pedido", style: TextStyle(color: Colors.white))),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}