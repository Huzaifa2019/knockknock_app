import 'package:flutter/material.dart';
import './WorkerAccount.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import './Buttonsfile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String url = 'https://knock-knock-f1915.firebaseio.com/';

String validatePhone(String value) {
  Pattern pattern = r'^\d{4}-\d{7}$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Enter valid phone number.';
  else
    return null;
}

class WorkerSignIn extends StatefulWidget {
  @override
  _WorkerSignInState createState() => _WorkerSignInState();
}

class _WorkerSignInState extends State<WorkerSignIn> {
  String phoneNumber;
  String password;

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    Map<String, dynamic> listFetchData;
    Map<String, dynamic> lFetchData;
    Map<String, dynamic> result;

    AlertDialog alert = AlertDialog(
      title: Text(
        "Warning",
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.w500, fontSize: 20),
      ),
      content: Text(
        "Your details doesn't exist, you have to create your account first!",
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
                return WorkerAccount(lFetchData);
              }),
            );
          },
        )
        //  okButton,
      ],
    );

    http.get('$url/workers.json').then((http.Response response) {
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
      decoration: InputDecoration(labelText: 'Phone number (03XX-XXXXXXX)'),
      keyboardType: TextInputType.phone,
      validator: validatePhone,
      onChanged: (String value) {
        phoneNumber = value;
      },
      onSaved: (String value) {
        phoneNumber = value;
      },
    );
  }

  Widget buildPasswordField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password'),
      validator: (String value) {
        if (value.isEmpty) {
          return "Password is Required.";
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
    return Form(
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
              buttonColor: Colors.blueAccent,
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
    );
  }
}
