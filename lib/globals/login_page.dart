import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals/ordered_products_provider.dart';
import 'package:flutter_application_1/globals/products_card.dart';
import 'package:flutter_application_1/globals/signup_page.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  bool isAuthenticated = false;
  late String userLastName = '';

  void loginUser(String lastName) {
    isAuthenticated = true;
    userLastName = lastName;
    notifyListeners();
  }

  void logoutUser() {
    isAuthenticated = false;
    notifyListeners();
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _usernameOrEmail = '';
  String _password = '';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
          child: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(16.0),
        width: 300,
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username or Email',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username or email';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _usernameOrEmail = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //Submit login credentials
                    _submitForm();
                  }
                },
                child: Text('Login'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                child: Text('Don\'t have an account? Sign up'),
              )
            ],
          ),
        ),
      )),
    );
  }

  void _submitForm() async {
    // Handle form Submission here
    // This is where you would typically send the data to your backend

    //Validate the form
    if (_formKey.currentState!.validate()) {
      //FOrm is Valid, proceed with login
      var formData = {
        'username': _usernameOrEmail,
        'password': _password,
      };
      var response = await http.post(
          Uri.parse('http://127.0.0.1:8000/users/login'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(formData));

      if (response.statusCode == 200) {
        //Successful login
        final responseData = jsonDecode(response.body);
        String userLastName = '';
        userLastName = responseData['last_name'];
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.loginUser(userLastName);

        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Login Successful'),
                content: Text('Welcome , $_usernameOrEmail !'),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(
                                      
                                    )));
                      },
                      child: Text('Ok'))
                ],
              );
            });
      } else {
        //Failed login
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Login Failed'),
                content: Text('Incoorrect username/email or password.'),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('OK'))
                ],
              );
            });
      }
    }
  }
}
