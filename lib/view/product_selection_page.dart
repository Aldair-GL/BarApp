import 'package:flutter/material.dart';
import '../model/product.dart';

class ProductSelectionPage extends StatefulWidget {
  @override
  _ProductSelectionPageState createState() => _ProductSelectionPageState();
}

class _ProductSelectionPageState extends State<ProductSelectionPage> {
  final List<Product> products = [
    Product(nombre: "Café", precio: 1.20),
    Product(nombre: "Té", precio: 1.10),
    Product(nombre: "Refresco", precio: 2.00),
    Product(nombre: "Cerveza", precio: 2.50),
    Product(nombre: "Bocadillo", precio: 3.50),
    Product(nombre: "Hamburguesa", precio: 6.00),
    Product(nombre: "Ensalada", precio: 4.50),
    Product(nombre: "Tarta", precio: 2.80),
    Product(nombre: "Helado", precio: 2.20),
    Product(nombre: "Agua", precio: 1.00),
  ];

  final Map<String, int> selected = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Seleccionar productos")),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (_, i) {
          final p = products[i];
          return ListTile(
            title: Text(p.nombre),
            subtitle: Text("${p.precio} €"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (!selected.containsKey(p.nombre)) return;
                    setState(() {
                      selected[p.nombre] =
                          (selected[p.nombre]! - 1).clamp(0, 99);
                      if (selected[p.nombre] == 0) selected.remove(p.nombre);
                    });
                  },
                ),
                Text(selected[p.nombre]?.toString() ?? "0"),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      selected[p.nombre] = (selected[p.nombre] ?? 0) + 1;
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              final result = selected.entries
                  .map((e) => Product(
                      nombre: e.key,
                      precio: products
                          .firstWhere((p) => p.nombre == e.key)
                          .precio,
                      cantidad: e.value))
                  .toList();
              Navigator.pop(context, result);
            },
            label: Text("Confirmar"),
          ),
          SizedBox(height: 10),
          FloatingActionButton.extended(
            backgroundColor: Colors.grey,
            onPressed: () => Navigator.pop(context),
            label: Text("Cancelar"),
          ),
        ],
      ),
    );
  }
}
