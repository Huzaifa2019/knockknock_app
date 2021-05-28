import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import './Buttonsfile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String url = 'https://knock-knock-f1915.firebaseio.com/';

class Contact extends StatefulWidget {
  _ContactState createState() => _ContactState();
}

String validateEmailContact(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  Pattern pattern2 = r'^\d{4}-\d{7}$';
  RegExp regex2 = new RegExp(pattern2);

  if (!regex.hasMatch(value)) {
    if (!regex2.hasMatch(value)) {
      return 'Enter valid email or contact number';
    } else {
      return null;
    }
  } else
    return null;
}

class _ContactState extends State<Contact> {
  var validateKey = GlobalKey<FormState>();
  String emailOrPhone;
  String name;
  String subject;
  String message;

  showAlertDialog(BuildContext context) {
    // set up the button
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "SENT",
        style: TextStyle(
            color: Colors.blueGrey, fontWeight: FontWeight.w500, fontSize: 20),
      ),
      content: Text(
        "Your message has been sent.",
        style: TextStyle(color: Colors.grey),
      ),
      actions: [
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            setState(() {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            });
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

  Widget build(BuildContext context) {
    void addData() {
      final Map<String, String> registerVal = {
        'name': name,
        'emailOrPhone': emailOrPhone,
        'subject': subject,
        'message': message,
      };

      http
          .post('$url/messages.json',
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
//    print(registerVal);
    }

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
                    "CONTACT US",
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 35.0,
                        fontFamily: 'bold',
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(255, 255, 255, 1)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  AutoSizeText(
                    "For any queries and further information, feel free to contact us.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15.0,
                        //  fontFamily: 'bold',
                        fontWeight: FontWeight.w500,
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
                  key: validateKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: AutoSizeText(
                              "Name",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: TextFormField(
                                  cursorColor: Colors.blueGrey,
                                  decoration:
                                      InputDecoration(labelText: 'Enter Name'),
                                  onChanged: (String v) {
                                    name = v;
                                  },
                                  validator: (String v) {
                                    if (v.isEmpty)
                                      return 'Please Enter Your Name';
                                    else
                                      return null;
                                  }))
                        ],
                      ),
                      //second row

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: AutoSizeText(
                              "Email or Contact",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: TextFormField(
                                cursorColor: Colors.blueGrey,
                                decoration: InputDecoration(
                                    labelText: 'Enter Email or Contact'),
                                validator: validateEmailContact,
                                onChanged: (String val) {
                                  emailOrPhone = val;
                                },
                              ))
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: AutoSizeText(
                              "Subject",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: TextFormField(
                                cursorColor: Colors.blueGrey,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                    labelText: 'Write a Subject'),
                                validator: (String val) {
                                  if (val.isEmpty)
                                    return 'Please Enter Subject';
                                  else
                                    return null;
                                },
                                onChanged: (String val) {
                                  subject = val;
                                },
                              ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: AutoSizeText(
                              "Message",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                cursorColor: Colors.blueGrey,
                                decoration: InputDecoration(
                                    labelText: 'Type Your Message'),
                                validator: (String val) {
                                  if (val.isEmpty)
                                    return 'Please Write Message';
                                  else
                                    return null;
                                },
                                onChanged: (String val) {
                                  message = val;
                                },
                              ))
                        ],
                      ),
                      (val == 1) ? buildCorrectionField() : SizedBox(height: 5),
                      SizedBox(height: 15),
                      AppButtons(
                          title: "SUBMIT",
                          buttonColor: Colors.lightBlue,
                          press: () {
                            if (!validateKey.currentState.validate()) {
                              setState(() {
                                val = 1;
                              });
                              return;
                            } else {
                              setState(() {
                                val = 0;
                              });

                              addData();
                              validateKey.currentState.save();
                            }
                          }),
                      SizedBox(height: 20),
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
