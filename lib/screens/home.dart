import 'package:bom_hamburguer/screens/cart.dart';
import 'package:bom_hamburguer/screens/orders.dart';
import 'package:flutter/material.dart';
import 'package:bom_hamburguer/_utils/color_theme.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Home extends StatefulWidget {
  /* Recuperando nome de usuario enviado da tela inicial */
  final String name;
  const Home({super.key, required this.name});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /* Carrega e converte os dados do JSON */
  Future<List<Map<String, dynamic>>> loadItems() async {
    final String manuItems = await rootBundle.loadString(
      'assets/menu_items.json',
    );
    final List<dynamic> items = jsonDecode(manuItems);
    return items.cast<Map<String, dynamic>>();
  }

  /* Função para adicionar itens no carrinho e confirmação por AlertDialog (modal) */
  List<Map<String, dynamic>> cart = [];
  void addToCart(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorTheme.primaryColor,
          title: Text('Confirmar'),
          content: Text(
            'Adicionar "${item['name']}" ao carrinho?',
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Adicionar'),
                  onPressed: () {
                    if (!cart.any(
                      (element) => element['type'] == item['type'],
                    )) {
                      Navigator.of(context).pop();
                      setState(() {
                        cart.add(item);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            '${item['name']} adicionado ao carrinho!',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            'Você já possui um ${item['type'].toUpperCase()} adicionado ao carrinho!',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  /* Inicializa lista de pedidos */
  List<List<Map<String, dynamic>>> orders = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.primaryColor,
      appBar: AppBar(
        title: Text(
          "BOM HAMBURGUER 🍔",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: ColorTheme.quaternaryColor,
      ),
      /* Exibe após confirmar que os dados do loadItems() foram carregados */
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: loadItems(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final items = snapshot.data!;
          return ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "BEM VINDO(A) ${widget.name}!",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    "Sabor irresistivel a cada mordida!",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24, 10, 24, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.monetization_on),
                    Text("Pedido Minimo \$20", style: TextStyle(fontSize: 16)),
                    Spacer(),
                    Icon(Icons.timer_outlined),
                    Text("40 - 60 min", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              /* Itera cada item da lista e cria um Widget */
              ...items.map((item) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Material(
                    color: ColorTheme.tertiaryColor,
                    child: InkWell(
                      onTap: () {
                        addToCart(item);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorTheme.quaternaryColor),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              margin: EdgeInsets.all(8),
                              child: Image.asset(
                                'assets/${item['image']}',
                                fit: BoxFit.contain,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${item['name']}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(item['description']),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 8, 8, 0),
                              child: Text(
                                '\$${item['price'].toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
      /* Botão flutuante para ir pro carrinho - DESATIVADO */
      /* floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Cart(cart: cart)),
          );
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.shopping_cart_outlined, color: Colors.white),
      ), */
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          switch (index) {
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Orders(orders: orders, name: widget.name),
                ),
              );
              break;
            case 2:
              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Cart(cart: cart)),
                  ) /* Após retorno do pagamento, cria pedido e limpa o carrinho */
                  .then((paymentDone) {
                    if (paymentDone == true) {
                      setState(() {
                        orders.add(List<Map<String, dynamic>>.from(cart));
                        cart.clear();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            'Pagamento via PIX recebido com sucesso!',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }
                  });
              break;
            default:
          }
        },
        currentIndex: 0,
        backgroundColor: ColorTheme.primaryColor,
        selectedItemColor: ColorTheme.quaternaryColor,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: 'Cardápio',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: 'Pedidos'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrinho',
          ),
        ],
      ),
    );
  }
}
