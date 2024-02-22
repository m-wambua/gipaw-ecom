

import 'dart:convert';
import 'package:flutter_application_1/globals/products_card.dart';
import 'package:http/http.dart' as http;

void sendOrderData(List<OrderedProduct> orderedProducts, String orderNumber, double grandTotal) async {
  final Uri uri = Uri.parse('http://localhost:3000/api/orders');

  // Prepare the order data as a JSON object
  final Map<String, dynamic> orderData = {
    'orderedProducts': orderedProducts.map((product) => product.toJson()).toList(),
    'orderNumber': orderNumber,
    'grandTotal': grandTotal,
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
}
