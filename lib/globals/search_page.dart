import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  final List<String> searchResults;
  const SearchPage({Key? key, required this.searchResults}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: ListView.builder(
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(searchResults[index]),
            );
          }),
    );
  }
}
