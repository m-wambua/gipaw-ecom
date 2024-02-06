class SearchService {
  //Define a dictionary mapping keywords to relevant items
  static Map<String, List<String>> searchIndex = {
    'shirt': ['Blue Shirt', 'Red Shirt', 'Striped Shirt'],
    'pants': ['Blue Pants', 'Black Pants', 'Khaki Pants'],
    'tie': ['Red Tie', 'Black Tie', 'Green Tie'],
    'track suit': ['Red Track Suit', 'Black Track Suit', 'Yellow Track Suit']
    // Add more key words and associated items/categories as needed
  };

// Function to perform search based on User Query
  static Future<List<String>> searchItems(String query) async {
    List<String> results = [];
    //Simulate asynchronous search operation (e.g, fetch data from API)
    await Future.delayed(Duration(seconds: 1));
    //Search for matching keywords
    searchIndex.forEach((keyword, items) {
      if (query.toLowerCase().contains(keyword)) {
        results.addAll(items);
      }
    });
    return results;
  }
}
