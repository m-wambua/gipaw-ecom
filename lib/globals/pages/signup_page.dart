import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _username = '';
  String _password = '';
  String _confirmPassword = '';
  String _phoneNumber = '';
  String _firstName = '';
  String _lastName = '';
  String _poBoxNumber = '';
  String _addressLine1 = '';
  String _addressLine2 = '';
  String _physicalLocation = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
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
                    labelText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    //Add email validation logic here
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!EmailValidator.validate(value!)) {
                      return 'Please Enter a valid email';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    // if (!isUsernameUnique(value)) {return 'This username is already taken';}
                    //Add email validation logic here
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _username = value;
                    });
                  },
                ),

                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    //Add email validation logic here
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _phoneNumber = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'First Name',
                        ),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          //Add email validation logic here
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _firstName = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Last name',
                        ),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          //Add email validation logic here
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _lastName = value;
                          });
                        },
                      ),
                    )
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    //Add email validation logic here
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
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    //Add email validation logic here
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _poBoxNumber = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),

                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Postal Address',
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    //Add email validation logic here
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _confirmPassword = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Address Line 1',
                        ),
                        keyboardType: TextInputType.streetAddress,
                        validator: (value) {
                          //Add email validation logic here
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _addressLine1 = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Address Line 2',
                        ),
                        keyboardType: TextInputType.streetAddress,
                        validator: (value) {
                          //Add email validation logic here
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _addressLine2 = value;
                          });
                        },
                      ),
                    )
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Physical Address',
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    //Add email validation logic here
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _physicalLocation = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                // Add other text form fields here
                ElevatedButton(
                    onPressed: () {
                      //validate the form
                      if (_formKey.currentState!.validate()) {
                        //Submit the form
                        _submitForm(context);
                      }
                    },
                    child: Text('Sign Up'))
              ],
            )),
      )),
    );
  }

  void _submitForm(BuildContext context) async {
    //Handle form submission here
    // This is where you would typically send the data to your backend
    var formData = {
      'username': _username,
      'email': _email,
      'password': _password,
      'phone_number': _phoneNumber,
      'first_name': _firstName,
      'last_name': _lastName,
      'po_box_number': _poBoxNumber,
      'address_line1': _addressLine1,
      'address_line2': _addressLine2,
      'physical_location': _physicalLocation,
    };

    //Make an HTTP POST request to your backend server
    var response = await http.post(
      Uri.parse(
        'http://127.0.0.1:8000/users/register',
      ),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(formData),
    );
    if (response.statusCode == 200) {
      //If the request was succesfful, display a success message
      print('Form submitted successful');
// Navigate back to the login page
      Navigator.pop(context);
    } else {
      // If the request failed ,display an error message
      print('Error submitting form: ${response.body}');
      print('Response status: ${response.statusCode}');
    }
  }
}
