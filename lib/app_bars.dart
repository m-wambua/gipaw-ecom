import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/pages/check_out_page.dart';
import 'package:flutter_application_1/globals/pages/login_page.dart';
import 'package:flutter_application_1/globals/pages/my_cart.dart';
import 'package:flutter_application_1/globals/structure/products_card.dart';
import 'package:flutter_application_1/globals/pages/profile_page.dart';
import 'package:flutter_application_1/globals/pages/search_page.dart';
import 'package:flutter_application_1/globals/structure/shopping_cart.dart';
import 'package:flutter_application_1/globals/pages/home_page_2.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';

class FirstSilverAppBar extends StatelessWidget {
  final ShoppingCart myShoppingCart = ShoppingCart();
  final VoidCallback? onListButtonPressed;
  final VoidCallback? onCartButtonPressed;

  FirstSilverAppBar(
      {Key? key, this.onListButtonPressed, this.onCartButtonPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 30.0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: FlexibleSpaceBar(
          title: Text('Gipaw'),
        ),
      ),
      actions: [
        IconButton(
          icon: Stack(children: [
            const Icon(Icons.list),
          ]),
          onPressed: onListButtonPressed,
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
            onPressed: onCartButtonPressed,
            icon: Stack(
              children: [
                Icon(Icons.add_shopping_cart),
              ],
            ))
      ],
      automaticallyImplyLeading: false,
      floating: true,
      pinned: true,
    );
  }
}

class SecondSliverAppBar extends StatefulWidget {
  final VoidCallback? onHomeButtonPressed;

  SecondSliverAppBar({Key? key, this.onHomeButtonPressed});
  @override
  State<SecondSliverAppBar> createState() => _SecondSliverAppBarState();
}

class _SecondSliverAppBarState extends State<SecondSliverAppBar> {
  final SidebarXController _sidebarXController =
      SidebarXController(selectedIndex: 0);

  TextEditingController searchController = TextEditingController();

  String searchText = '';

  List<Product> searchResults = [];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return SliverAppBar(
      expandedHeight: 50.0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.green, Colors.blue],
        )),
        child: FlexibleSpaceBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: widget.onHomeButtonPressed,
                  icon: Icon(Icons.home)),
              const SizedBox(
                width: 5,
              ),
              IconButton(
                  onPressed: () {
                    SidebarX(
                      controller: _sidebarXController,
                      items: const [SidebarXItem(icon: Icons.build)],
                    );
                  },
                  icon: const Icon(Icons.add_circle_outline)),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  // TODO: Add functionality for more
                  _showMenuBar(context);
                },
              ),
              const SizedBox(
                width: 50,
              ),
              Expanded(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search...',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        _performSearch(searchText);
                      },
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
              )),
              const Spacer(),
              IconButton(
                  icon: const Icon(Icons.person),
                  onPressed: () {
                    if (userProvider.isAuthenticated) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()));
                    } else {
                      //Navigate to login page if not authenticated
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    }
                  }
                  // TODO: Add functionality for sign-in

                  ),
              if (userProvider.isAuthenticated) Text(userProvider.userLastName),
              const SizedBox(
                width: 5,
              ),
              ElevatedButton(
                onPressed: () {
                  //TODO: implement functionality for 'About' button
                  showAboutDialog(
                    context: context,
                    applicationName: 'Dexter Labs App',
                    applicationVersion: '1.0.0',
                    applicationLegalese: '@ 2023 Dxter Labs',
                  );
                },
                child: const Text(
                  'About',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
      automaticallyImplyLeading: false,
      floating: false,
      pinned: true,
    );
  }

  void _performSearch(String searchQuery) {
    // Perform search

    // Navigate to the SearchPage with the list of search results
    Navigator.push(
      context as BuildContext,
      MaterialPageRoute(
        builder: (context) => SearchPage(
          query: searchText,
        ),
      ),
    );

    //print(searchResults);
  }

// FUnction to show the menu bar
  void _showMenuBar(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.help),
                    title: const Text('Help'),
                    onTap: () {
                      // Handle help action
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.build),
                    title: const Text('Build your uniform'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ));
        });
  }

  void _sidebarNavigation(BuildContext context) {
    SidebarX(
      controller: SidebarXController(selectedIndex: 0),
      items: const [SidebarXItem(icon: Icons.build, label: 'Build')],
    );
  }
}
