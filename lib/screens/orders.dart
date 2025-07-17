import 'package:bom_hamburguer/_utils/color_theme.dart';
import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  final List<List<Map<String, dynamic>>> orders;
  final String name;

  const Orders({super.key, required this.orders, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.primaryColor,
      appBar: AppBar(
        title: Text(
          "Pedidos 📋",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: ColorTheme.quaternaryColor,
      ),
      body: orders.isEmpty
          ? Center(
              child: Text(
                'Nenhum pedido realizado',
                style: TextStyle(
                  fontSize: 20,
                  color: ColorTheme.quaternaryColor,
                ),
              ),
            )
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                final total = order.fold(
                  0.0,
                  (sum, item) => sum + (item['price'] as double),
                );
                return Card(
                  child: ListTile(
                    title: Text(
                      "Pedido #${index + 1} - $name",
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...order.map((item) {
                          return Text(
                            "${item['name']} - \$${item['price'].toStringAsFixed(2)}",
                            style: TextStyle(fontSize: 16),
                          );
                        }),
                        SizedBox(height: 8),
                        Text(
                          "Valor Final: \$${total.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
