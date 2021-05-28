import 'dart:convert';

import 'package:flutter/material.dart';
import './Buttonsfile.dart';
import 'package:http/http.dart' as http;

String url = 'https://knock-knock-f1915.firebaseio.com/';

class WorkerJoin extends StatefulWidget {
  @override
  _WorkerJoinState createState() => _WorkerJoinState();
}

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

class _WorkerJoinState extends State<WorkerJoin> {
  String name;
  String age;
  String cnic;
  String phoneNumber;
  String area;
  String experience;
  String charges;
  String password;
  String password2;
  String category = 'Driver';
  String gender = 'Male';
  String categoryDropDown = 'Driver';
  String genderDropDown = 'Male';

  Map<String, dynamic> addData() {
    Map<String, dynamic> listFetchData;
    Map<String, dynamic> result;
    http.get('$url/workers.json').then((http.Response response) {
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
          'age': age,
          'gender': gender,
          'cnic': cnic,
          'phoneNumber': phoneNumber,
          'area': area,
          'category': category,
          'experience': experience,
          'charges': charges,
          'password': password,
        };

        setState(() {
          if (listFetchData == null) {
            http
                .post('$url/workers.json',
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
        "CONGRATULATIONS",
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
            "You are registered successfully.",
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
//            Navigator.of(context).pop();
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget buildNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      validator: (String value) {
        if (value.isEmpty) {
          return "Name is Required.";
        }
      },
      onSaved: (String value) {
        name = value;
      },
    );
  }

  Widget buildAgeField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Age'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        int _age = int.tryParse(value);

        if (_age == null) {
          return "Age is Required.";
        } else if (_age < 0) {
          return "Enter valid age.";
        } else if (_age < 18) {
          return "Minimum age required to register is 18 years.";
        }
      },
      onSaved: (String value) {
        age = value;
      },
    );
  }

  Widget buildGenderField() {
    return Row(
      children: <Widget>[
        Text("Choose Gender\t\t\t\t",
            style: TextStyle(fontSize: 17, color: Colors.black54)),
        DropdownButton<String>(
          value: genderDropDown,
          //hint: Text('Select Category   '),
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          onChanged: (String newValue) {
            gender = newValue;
            setState(() {
              genderDropDown = newValue;
            });
          },
          items: <String>[
            'Male',
            'Female',
            'Other',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget buildPhoneField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Phone number (03XX-XXXXXXX)'),
      keyboardType: TextInputType.phone,
      validator: validatePhone,
      onChanged: (String value) {
        phoneNumber = value;
      },
    );
  }

  Widget buildAreaField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Area (e.g. DHA Phase-5)'),
      validator: (String value) {
        if (value.isEmpty) {
          return "Area is Required.";
        }
      },
      onSaved: (String value) {
        area = value;
      },
    );
  }

  showDuplicateAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "WARNING",
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

  Widget buildCnicField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'CNIC (XXXXX-XXXXXXX-X)'),
      validator: validateCNIC,
      onSaved: (String value) {
        cnic = value;
      },
    );
  }

  Widget buildCategoryField() {
    return Row(
      children: <Widget>[
        Text("Choose Category\t\t\t\t",
            style: TextStyle(fontSize: 17, color: Colors.black54)),
        DropdownButton<String>(
          value: categoryDropDown,
          //hint: Text('Select Category   '),
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          onChanged: (String newValue) {
            category = newValue;
            setState(() {
              categoryDropDown = newValue;
            });
          },
          items: <String>[
            'Driver',
            'Maid',
            'Day-care',
            'Cook',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget buildExperienceField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Experience (In Years)'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return "Experience is Required.";
        }
      },
      onSaved: (String value) {
        experience = value;
      },
    );
  }

  Widget buildChargesField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Charges (Per Day)'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return "Charges are Required.";
        }
      },
      onSaved: (String value) {
        charges = value;
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
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildNameField(),
          buildAgeField(),
          buildGenderField(),
          buildAreaField(),
          buildCnicField(),
          buildCategoryField(),
          buildPhoneField(),
          buildPasswordField(),
          buildPassword2Field(),
          buildExperienceField(),
          buildChargesField(),
          (val == 1) ? buildCorrectionField() : SizedBox(height: 5),
          SizedBox(height: 15),
          AppButtons(
              title: "JOIN",
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
                  addData();
                }
              }),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
