
# bom_hamburguer
We're with "BOM HAMBURGUER" and would like to create a software solution for placing and managing orders.

You are responsible for developing a mobile application (Android/iOS). The business requirements are outlined below:

**The user can choose three sandwich options:**

X Burger – $ 5,00
X Egg - $ 4,50
X Bacon - $ 7,00
 
**User can also add Extras:**

Fries -  $ 2,00
Soft Drink - $ 2,50

**Rules:**

- If the customer selects a sandwich, fries, and soft drink, then the customer will have 20% discount.

- If the customer selects a sandwich and soft drink, then the customer will have 15% discount.

- If the customer selects a sandwich and fries, then the customer will have a 10% discount.

- Each order **cannot contain more than one sandwich, fries, or soda**. If two identical items are sent,  **the APP should return an error message** displaying the reason.

**Requirements:**

1) Create a feature to list all sandwiches and extras.

2) Create a feature to add a sandwich to the cart.

3) Create a feature to show the cart (all the items selected from the user) and display how much they need to pay.

4) Create a feature to pay (fake payment, it doesn’t need to enter any source of payment) and create an order. Payment only requires the customer’s name.

**Observations:**
- The Project needs to be in **Flutter**. - You **don’t need to build an API**, you can use the local storage or SQL lite.

- Please upload the **source code to a GitHub repository**.
- 
## Anotações
- definindo temas e imagens que serão usadas. Itens da loja inseridos em um arquivo JSON.
- criação da tela de Login (sem autenticação).
- criação da tela principal (Home):
- recuperando nome de usuario vindo de outra tela
- função assíncrona loadItems() que ira carregar os dados do JSON
- rootBundle.loadString() para ler o conteudo do JSON como uma String
- await para garantir que a leitura termine antes de continuar
- jsonDecode() para converter a String em uma List<dyanmics> (um tipo bem genérico, por isso fazemos o primo passo)
- .cast<Map<String,  dynamic>>() para transformar a lista do tipo: List<dynamic> para esse: List<Map<String,  dynamic>>.
- FutureBuilder colocado no body para esperar o resultado de uma função, definido nessa parte future: loadItems()
- a parte do builder é chamado automaticamente pelo Flutter quando acontece algo com o Future (seja carregando, sucesso ou erro), o snapshot é o estado atual do Future
- if com o snapshot para indicar um icone de carregamento enquanto os dados nao chegam
- quando os dados chegam eles são salvos na variável items
- função de adicionar ao carrinho com modal e confirmação
- feito o envio da lista cart para a tela Cart
- tela do carrinho com a função de calcular descontos e limpar carrinho após confirmar pedido
- tela de pedidos, recebendo a lista do carrinho e o nome do cliente