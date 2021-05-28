import 'package:flutter/material.dart';
import './HomeScreen.dart';
import './Buttonsfile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Register.dart';

String url = 'https://knock-knock-f1915.firebaseio.com/';

String validateCNIC(String value) {
  Pattern pattern = r'^\d{5}-\d{7}-\d{1}$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Enter valid CNIC.';
  else
    return null;
}

String validatePhone(String value) {
  Pattern pattern = r'^\d{4}-\d{7}$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Enter valid phone number.';
  else
    return null;
}

class ClientJoin extends StatefulWidget {
  @override
  _ClientJoinState createState() => _ClientJoinState();
}

class _ClientJoinState extends State<ClientJoin> {
  String name;
  String cnic;
  String phoneNumber;
  String area;
  String password;
  String password2;

  Map<String, dynamic> addData() {
    Map<String, dynamic> listFetchData;
    Map<String, dynamic> result;
    http.get('$url/clients.json').then((http.Response response) {
      print('STATUS CODE: ' + (response.statusCode).toString());
      result = jsonDecode(response.body);
      setState(() {
        if (result != null) {
          result.forEach((String ID, dynamic data) {
            final fdata = {
              'id': ID,
              'phoneNumber': data['phoneNumber'],
            };
            if (data['phoneNumber'] == phoneNumber) {
              listFetchData = fdata;
            }
          });
        }
        final Map<String, String> registerVal = {
          'name': name,
          'cnic': cnic,
          'phoneNumber': phoneNumber,
          'area': area,
          'password': password,
        };

        setState(() {
          if (listFetchData == null) {
            http
                .post('$url/clients.json',
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(registerVal))
                .then((http.Response response) {
              print(jsonDecode(response.body));
              print(response.statusCode);
              if (response.statusCode == 200) {
                showAlertDialog(context);
              }
            });
          } else if (listFetchData['phoneNumber'] == phoneNumber) {
            showDuplicateAlertDialog(context);
            return;
          }
        });
      });
    });
    return listFetchData;
  }

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Congratulations",
        style: TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.w600,
            fontSize: 25),
      ),
      content: FittedBox(
        fit: BoxFit.contain,
        child: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(10),
          child: Text(
            "You are registered.",
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.blueGrey),
          ),
        ),
      ),
      actions: [
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.of(context, rootNavigator: true).pop();
//            Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context) {
//                return JoinUsForm();
//              }),
//            );
          },
        )
        //  okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showDuplicateAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Warning",
        style: TextStyle(
            color: Colors.redAccent, fontWeight: FontWeight.w600, fontSize: 25),
      ),
      content: FittedBox(
        fit: BoxFit.contain,
        child: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(10),
          child: Text(
            "This phone number is already registered!",
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.blueGrey),
          ),
        ),
      ),
      actions: [
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        )
        //  okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget buildNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      validator: (String value) {
        if (value.isEmpty) {
          return "Name is required.";
        }
      },
      onSaved: (String value) {
        name = value;
      },
    );
  }

  Widget buildPhoneField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Phone number (03XX-XXXXXXX)'),
      keyboardType: TextInputType.phone,
      validator: validatePhone,
      onSaved: (String value) {
        phoneNumber = value;
      },
    );
  }

  Widget buildAreaField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Home Address'),
      validator: (String value) {
        if (value.isEmpty) {
          return "Home address is required.";
        }
      },
      onSaved: (String value) {
        area = value;
      },
    );
  }

  Widget buildCnicField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'CNIC (XXXXX-XXXXXXX-X)'),
      validator: validateCNIC,
      onSaved: (String value) {
        cnic = value;
      },
    );
  }

  Widget buildPasswordField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password'),
      validator: (String value) {
        if (value.isEmpty) {
          return "Password is required.";
        }
      },
      obscureText: true,
      onChanged: (String value) {
        password = value;
      },
      onSaved: (String value) {
        password = value;
      },
    );
  }

  Widget buildPassword2Field() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Confirm Password'),
      obscureText: true,
      validator: (String value) {
        if (value != password) {
          return "Password must be same.";
        }
      },
      onSaved: (String value) {
        password2 = value;
      },
    );
  }

  Widget buildCorrectionField() {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Text(
        "Kindly enter details correctly",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.redAccent,
          fontSize: 15,
        ),
      ),
    );
  }

  int val = 0;

  initState() {
    val = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildNameField(),
          buildPhoneField(),
          buildCnicField(),
          buildAreaField(),
          buildPasswordField(),
          buildPassword2Field(),
          (val == 1) ? buildCorrectionField() : SizedBox(height: 5),
          SizedBox(height: 20),
          AppButtons(
              title: "JOIN",
              buttonColor: Colors.lightBlue,
              press: () {
                if (!_formKey.currentState.validate()) {
                  setState(() {
                    val = 1;
                  });
                  return;
                } else {
                  setState(() {
                    val = 0;
                  });

                  _formKey.currentState.save();
                  addData();
                }
              }),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
