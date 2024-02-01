import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;

  Product({required this.name, required this.price});
}

class CounterNotifier extends ChangeNotifier {
  int _itemCount = 0;

  int get itemCount => _itemCount;

  void addToCart() {
    _itemCount++;
    notifyListeners();
  }
}

class ShoppingCart {
  List<Product> items = [];
  int _itemCount = 0;
  int get itemCount =>
      _itemCount; // COunter for the number of items in the cart
  void addToCart(Product product) {
    items.add(product);
    _itemCount++;
    NotificationListener;
    print('Item added to the cart. Updated itemcount: $_itemCount');
    print('the counter is here: ');
    // Increamnet the count when adding a product
  }

  int getItemCount() {
    return _itemCount;
  }

  void removeProduct(Product product) {
    items.remove(product);
    _itemCount--;
    NotificationListener;
    print('Item removed from the cart. Updated item count: $_itemCount');
  }

  double calculatedTotalPrice() {
    double totalPrice = 0.0;
    for (var product in items) {
      totalPrice += product.price;
    }
    return totalPrice;
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final ShoppingCart
      shoppingCart; //pass the shopping cart instance to the porduct card

  const ProductCard(
      {Key? key, required this.product, required this.shoppingCart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: 150,
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 4 / 3,
              child: Container(
                color: Colors.grey, // Placeholder for product image
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 14, color: Colors.green),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // Add the product to the shopping cart
                        shoppingCart.addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('Product added to the cart'),
                          duration: const Duration(seconds: 2),
                        ));
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [Text('Add to cart')],
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
