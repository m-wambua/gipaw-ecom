import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Define a function to fetch search results from the Flask backend
Future<List<Map<String, dynamic>>> fetchSearchResults(String query) async {
  final response = await http.get(Uri.parse('http://127.0.0.1:5000//search?q=$query'));

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON response
    List<dynamic> data = json.decode(response.body);
    // Convert each item to a Map<String, dynamic>
    List<Map<String, dynamic>> searchResults = data.cast<Map<String, dynamic>>();
    return searchResults;
  } else {
    // If the server returns an error response, throw an exception
    throw Exception('Failed to load search results');
  }
}

// Now you can call fetchSearchResults function to fetch search results
// For example:
// List<Map<String, dynamic>> results = await fetchSearchResults('Red');
