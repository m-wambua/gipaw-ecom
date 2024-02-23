import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/structure/products_card.dart';
import 'package:flutter_application_1/globals/services/searchservice.dart';

class SearchPage extends StatefulWidget {
  final String query;

  const SearchPage({Key? key, required this.query}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<List<Map<String, dynamic>>> _searchResults;
  late final Product product;
  @override
  void initState() {
    super.initState();
    _performSearch(widget.query);
  }

  Future<void> _performSearch(String query) async {
    setState(() {
      _searchResults = fetchSearchResults(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _searchResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> searchResults = snapshot.data!;
            return ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final result = searchResults[index];
                final imageUrl = result['imageUrl'];
                //final imageUrl = result['imageUrl'] as String? ?? 'default_image_url'; // Provide a default image URL if 'imageUrl' is null
    
                return ListTile(
                  title: Text(result['name']),
                  subtitle: Text(
                      '\$${result['price']['start'].toStringAsFixed(2)}-\$${result['price']['end'].toStringAsFixed(2)}'),
                  leading: imageUrl !=null ?Image.network(
                    imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ): Icon(Icons.image),
                  // Add more UI elements as needed
                );
              },
            );
          }
        },
      ),
    );
  }
}
