import 'package:flutter/material.dart';
import './Buttonsfile.dart';
import './AdminAccount.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String url = 'https://knock-knock-f1915.firebaseio.com/';

String validateEmailContact(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  Pattern pattern2 = r'^\d{4}-\d{7}$';
  RegExp regex2 = new RegExp(pattern2);

  if (!regex.hasMatch(value)) {
    if (!regex2.hasMatch(value)) {
      return 'Enter valid email or phone number';
    } else {
      return null;
    }
  } else
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

class AdminSignIn extends StatefulWidget {
  @override
  _AdminSignInState createState() => _AdminSignInState();
}

class _AdminSignInState extends State<AdminSignIn> {
  String phoneNumber;
  String password;

  showAlertDialog(BuildContext context) {
    Map<String, dynamic> listFetchData;
    Map<String, dynamic> lFetchData;
    Map<String, dynamic> result;

    // set up the AlertDialog

    AlertDialog alert = AlertDialog(
      title: Text(
        "Warning",
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.w500, fontSize: 20),
      ),
      content: Text(
        "Invalid email or phone no!",
        style: TextStyle(color: Colors.grey),
      ),
      actions: [
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            setState(() {
              Navigator.of(context, rootNavigator: true).pop();
            });
          },
        )
        //  okButton,
      ],
    );
    AlertDialog alert2 = AlertDialog(
      title: Text(
        "Warning",
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.w500, fontSize: 20),
      ),
      content: Text(
        "Your password is incorrect!",
        style: TextStyle(color: Colors.grey),
      ),
      actions: [
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            setState(() {
              Navigator.of(context, rootNavigator: true).pop();
            });
          },
        )
        //  okButton,
      ],
    );
    AlertDialog alert3 = AlertDialog(
      title: Text(
        "Successful",
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
            "Signed in successfully.",
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return AdminAccount(lFetchData);
              }),
            );
          },
        )
        //  okButton,
      ],
    );

    http.get('$url/admin.json').then((http.Response response) {
      print('STATUS CODE: ' + (response.statusCode).toString());
      result = jsonDecode(response.body);
      setState(() {
        if (result != null) {
          result.forEach((String ID, dynamic data) {
            final fdata = {
              'id': ID,
              'password': data['password'],
              'phoneNumber': data['phoneNumber'],
              'name': data['name'],
            };
            if (phoneNumber == data['phoneNumber']) {
              listFetchData = fdata;
            }
          });
        }
        print(listFetchData);
        // show the dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            if (listFetchData == null ||
                listFetchData['phoneNumber'] != phoneNumber) {
              return alert;
            } else if (listFetchData['phoneNumber'] == phoneNumber &&
                listFetchData['password'] != password) {
              return alert2;
            } else if (listFetchData['phoneNumber'] == phoneNumber &&
                listFetchData['password'] == password) {
              lFetchData = listFetchData;
              return alert3;
            }
            return alert;
          },
        );
      });
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget buildPhoneField() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'Email or Phone no (03XX-XXXXXXX)'),
      keyboardType: TextInputType.text,
      validator: validateEmailContact,
      onSaved: (String value) {
        phoneNumber = value;
      },
      onChanged: (String value) {
        phoneNumber = value;
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
    return MaterialApp(
      home: Scaffold(
          body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/image/bluegradient.jpg"),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * .35,
            color: Color.fromRGBO(255, 255, 255, 0.39),
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * .025,
              horizontal: 20,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AutoSizeText(
                    "ADMIN",
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 35.0,
                        fontFamily: 'bold',
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(255, 255, 255, 1)),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.05,
              MediaQuery.of(context).size.height * .35,
              MediaQuery.of(context).size.width * 0.05,
              0,
            ),
            child: ListView(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buildPhoneField(),
                      buildPasswordField(),
                      (val == 1) ? buildCorrectionField() : SizedBox(height: 5),
                      SizedBox(height: 20),
                      AppButtons(
                          title: "Sign In",
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
                              showAlertDialog(context);
                            }
                          }),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
