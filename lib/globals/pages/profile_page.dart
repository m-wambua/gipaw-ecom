import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/globals/pages/login_page.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userLastName = userProvider.userLastName;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
              onPressed: () {
// Call the logout function when the logout button is pressed
                logout(context);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Welcome ${userLastName}'),

           IconButton(
              onPressed: () {
// Call the logout function when the logout button is pressed
                logout(context);
              },
              icon: Icon(Icons.logout))
        ],
      )),
    );
  }
}

void logout(BuildContext context) {
  //Clear user authentication state and navigate back to login page

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
    (route) => false, // Remove all previous routes from stack
  );
}
