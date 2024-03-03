import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/globals/structure/products_card.dart';
import 'package:http/http.dart' as http;

Future<bool> sendOrderData(List<OrderedProduct> orderedProducts,
    String orderNumber, double grandTotal, int userId) async {
  final Uri uri = Uri.parse('http://127.0.0.1:8000/orders/');
  List<Map<String, dynamic>> orderedProductsData = [];
  for (var product in orderedProducts) {
    orderedProductsData.add({
      'name': product.product.name,
      'quantity': product.quantity,
      'size': product.size,
      'total_price': product.totalPrice,
    });
  }

  // Prepare the order data as a JSON object
  final Map<String, dynamic> orderData = {
    'user_id': userId,
    'order_number': orderNumber,
    'grand_total': grandTotal,
    'ordered_products': orderedProductsData,
  };

  // Send the order data to the server
  final response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(orderData),
  );

  // Check the response status and handle errors if needed
  if (response.statusCode == 200) {
    print('Order data sent successfully');
  } else {
    print('Failed to send order data: ${response.statusCode}');
  }
  print(userId);
  print(orderNumber);
  print(grandTotal);
  print('Ordered Products:');
  for (var product in orderedProducts) {
    print('Name: ${product.product.name}');
    print('Quantity: ${product.quantity}');
    print('Size: ${product.size}');
    print('Total Price: ${product.totalPrice}');
    print('---');
  }
  // Ensure that the functon returns a value in all possible code paths

  return false;// Add this line to handle the case where the function may complete withour returning a value
}
