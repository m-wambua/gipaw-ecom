import 'package:flutter/material.dart';

import 'package:flutter_application_1/globals/product_details-page.dart';
import 'package:flutter_application_1/globals/shopping_cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Product {
  final String name;
  final RangeOrString size;
  final Range price;
  final String imageUrl;
  double? selectedSize;

  Product(
      {required this.name,
      required this.price,
      required this.imageUrl,
      required this.size});
  //Getter method for the name property
  String get productName => name;

  
}

class Range {
  final double start;
  final double end;
  Range({required this.start, required this.end});
}

class RangeOrString {
  final Range? range;
  final List<String>? sizes;

  RangeOrString({this.range, this.sizes});
}

Range generateNumericSizeRange(int start, int end) {
  List<double> sizes = [];
  for (int i = start; i <= end; i += 2) {
    sizes.add(i.toDouble());
  }
  return Range(start: sizes.first, end: sizes.last);
}

class CounterNotifier extends ChangeNotifier {
  int _itemCount = 0;

  int get itemCount => _itemCount;

  void addToCart() {
    _itemCount++;
    notifyListeners();
  }
}

class OrderedProduct {
  final Product product;
  final int quantity;
  final String size;
  final double totalPrice;
  OrderedProduct(
      {required this.product,
      required this.quantity,
      required this.size,
      required this.totalPrice});

        Map<String, dynamic> toJson() {
    return {
      'name': product,
      'price': totalPrice,
      'quantity': quantity,
      'size':size,
    };
  }

  factory OrderedProduct.fromJson(Map<String, dynamic> json) {
    return OrderedProduct(
      product: json['name'],
      totalPrice: json['price'],
      quantity: json['quantity'],
      size: json['size'],
    );
  }
}




class ProductCard extends StatelessWidget {
  final Product product;
  
  final ShoppingCart
      shoppingCart; // Pass the shopping cart instance to the product card

  const ProductCard(
      {Key? key, required this.product, required this.shoppingCart, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(
              product: product,
              shoppingCart: shoppingCart,
              
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        width: 250,
        child: Card(
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 21 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            product.imageUrl), // Use imageUrl from Product
                        fit: BoxFit.contain),
                  ),
                  // Placeholder for product image
                ),
              ),
              Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '\$${product.price.start.toStringAsFixed(2)}-\$${product.price.end.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.green),
                        ),
                        const SizedBox(height: 4),
                        ElevatedButton(
                          onPressed: () {
                            // Add the product to the shopping cart
                            shoppingCart.addToCart(product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Product added to the cart'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [Text('Add to cart')],
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
