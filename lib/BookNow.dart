import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'Buttonsfile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String url = 'https://knock-knock-f1915.firebaseio.com/';

class BookNowForm extends StatefulWidget {
  String workerName;
  String workerID;
  String workerCategory;
  String workerPhone;
  String workerCharges;

  @override
  BookNowForm({
    Key key,
    this.workerName,
    this.workerID,
    this.workerCategory,
    this.workerPhone,
    this.workerCharges,
  }) : super(key: key);

  _BookNowFormState createState() => _BookNowFormState(
        workerID,
        workerName,
        workerCategory,
        workerPhone,
        workerCharges,
      );
}

class _BookNowFormState extends State<BookNowForm> {
  String bookName;
  String bookPhoneNumber;
  String bookArea;
  String bookExtraInstructions = "No";
  String fromDate = '';
  String toDate = '';
  String workerName;
  String workerCategory;
  String workerPhone;
  String workerCharges;
  String total;

  String password;
  String workerID;
  String bookID;
  String phoneNumber;

  DateTime selectedFromDate = null;
  DateTime selectedToDate = null;

  _BookNowFormState(
    this.workerID,
    this.workerName,
    this.workerCategory,
    this.workerPhone,
    this.workerCharges,
  );

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<FormState> _bookFormKey = GlobalKey<FormState>();

  String validatePhone(String bookValue) {
    Pattern pattern = r'^\d{4}-\d{7}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(bookValue))
      return 'Enter Valid Phone Number.';
    else
      return null;
  }

  Widget buildBookNameField() {
    return TextFormField(
      enabled: false,
      decoration: InputDecoration(labelText: 'Name'),
      validator: (String bookValue) {
        if (bookValue.isEmpty) {
          return "Name is Required.";
        }
        return null;
      },
      onSaved: (String bookValue) {
        bookName = bookValue;
      },
    );
  }

  Widget buildBookAreaField() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.3,
          ),
        ),
        color: Colors.transparent,
      ),
      child: TextFormField(
        enabled: false,
        decoration: InputDecoration(labelText: 'Home Address'),
        validator: (String bookValue) {
          if (bookValue.isEmpty) {
            return "Home Address is Required.";
          }
          return null;
        },
        onSaved: (String bookValue) {
          bookArea = bookValue;
        },
      ),
    );
  }

  Widget buildExtraInstructionsField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Extra Instructions (If Any)'),
      minLines: 1,
      maxLines: 5,
      onChanged: (String bookValue) {
        bookExtraInstructions = bookValue;
      },
    );
  }

  Widget buildBookPhoneField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Phone Number (03XX-XXXXXXX)'),
      keyboardType: TextInputType.phone,
      validator: validatePhone,
      onSaved: (String bookValue) {
        bookPhoneNumber = bookValue;
      },
      onChanged: (String bookValue) {
        bookPhoneNumber = bookValue;
      },
    );
  }

  Widget buildPhoneField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Phone Number (03XX-XXXXXXX)'),
      keyboardType: TextInputType.phone,
      validator: validatePhone,
      onSaved: (String bookValue) {
        phoneNumber = bookValue;
      },
      onChanged: (String bookValue) {
        phoneNumber = bookValue;
      },
    );
  }

  Widget buildWorkerPhoneField() {
    return TextFormField(
      enabled: false,
      decoration:
          InputDecoration(labelText: 'Worker Phone Number (03XX-XXXXXXX)'),
      keyboardType: TextInputType.phone,
      validator: validatePhone,
      onSaved: (String bookValue) {
        workerPhone = bookValue;
      },
      initialValue: workerPhone,
    );
  }

  Widget buildWorkerNameField() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.3,
          ),
        ),
        color: Colors.transparent,
      ),
      child: TextFormField(
        enabled: false,
        decoration: InputDecoration(labelText: 'Worker Name'),
        onSaved: (String bookValue) {
          workerCategory = bookValue;
        },
        validator: (String bookValue) {
          if (bookValue.isEmpty) {
            return "Worker Name is required.";
          }
          return null;
        },
        initialValue: workerName,
      ),
    );
  }

  Widget buildWorkerCategoryField() {
    return TextFormField(
      enabled: false,
      decoration: InputDecoration(labelText: 'Worker Category'),
      validator: (String bookValue) {
        if (bookValue.isEmpty) {
          return "Worker Category is required.";
        }
        return null;
      },
      onSaved: (String bookValue) {
        workerCategory = bookValue;
      },
      initialValue: workerCategory,
    );
  }

  Widget buildWorkerChargesField() {
    return TextFormField(
      enabled: false,
      decoration: InputDecoration(labelText: 'Worker Charges'),
      validator: (String bookValue) {
        if (bookValue.isEmpty) {
          return "Worker Charges is required.";
        }
        return null;
      },
      onSaved: (String bookValue) {
        workerCharges = bookValue;
      },
      initialValue: workerCharges,
    );
  }

  @override
  Widget build(BuildContext context) {
    showReceiptAlertDialog(
        BuildContext context, Map<String, dynamic> lFetchData) {
      print(lFetchData);

      var size = MediaQuery.of(context).size;
      return showDialog(
          context: context,
          builder: (BuildContext context) => Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: size.width,
                  color: Colors.transparent,
                  child: ListView(
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
//                            elevation: 0.0,

//                            color: Colors.white,
                            margin: EdgeInsets.all(5),
                            alignment: Alignment.center,
                            padding:
                                EdgeInsets.only(top: 20, left: 10, right: 10),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Your appointment has been successfully booked ! ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      //  fontFamily: 'bold',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Text(
                                    "We will contact you shortly after worker's approval!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        //  fontFamily: 'bold',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
//                                mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(flex: 2, child: Container()),
                                    Expanded(
                                      flex: 14,
//                                    width: MediaQuery.of(context).size.width * .24,
                                      child: Text(
                                        "Name",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 1, child: Container()),
                                    Expanded(
                                      flex: 17,
//                                    width: MediaQuery.of(context).size.width * .36,
                                      child: Text(
                                        "$bookName",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 2, child: Container()),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
//                                mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(flex: 2, child: Container()),
                                    Expanded(
//                                    width: size.width * 0.24,
                                      flex: 14,
                                      child: Text(
                                        "Address",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 1, child: Container()),
                                    Expanded(
//                                    width: size.width * 0.36,
                                      flex: 17,
                                      child: Text(
                                        "$bookArea",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 2, child: Container()),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
//                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(flex: 2, child: Container()),
                                    Expanded(
//                                      width: size.width * 0.24,
                                      flex: 14,
                                      child: Text(
                                        "Phone No",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 1, child: Container()),
                                    Expanded(
                                      flex: 17,
//                                      width: size.width * 0.36,
                                      child: Text(
                                        "$bookPhoneNumber",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 2, child: Container()),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
//                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(flex: 2, child: Container()),
                                    Expanded(
//                                      width: size.width * 0.24,
                                      flex: 14,
                                      child: Text(
                                        "Worker Name",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 1, child: Container()),
                                    Expanded(
                                      flex: 17,
//                                      width: size.width * 0.36,
                                      child: Text(
                                        "$workerName",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 2, child: Container()),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
//                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(flex: 2, child: Container()),
                                    Expanded(
//                                      width: size.width * 0.24,
                                      flex: 14,
                                      child: Text(
                                        "Worker Category",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 1, child: Container()),
                                    Expanded(
                                      flex: 17,
//                                      width: size.width * 0.36,
                                      child: Text(
                                        "$workerCategory",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 2, child: Container()),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
//                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(flex: 2, child: Container()),
                                    Expanded(
//                                      width: size.width * 0.24,
                                      flex: 14,
                                      child: Text(
                                        "Worker Phone No",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 1, child: Container()),
                                    Expanded(
                                      flex: 17,
//                                      width: size.width * 0.36,
                                      child: Text(
                                        "$workerPhone",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 2, child: Container()),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
//                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(flex: 2, child: Container()),
                                    Expanded(
//                                      width: size.width * 0.24,
                                      flex: 14,
                                      child: Text(
                                        "Charges per day",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 1, child: Container()),
                                    Expanded(
                                      flex: 17,
//                                      width: size.width * 0.36,
                                      child: Text(
                                        "$workerCharges",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 2, child: Container()),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
//                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(flex: 2, child: Container()),
                                    Expanded(
//                                      width: size.width * 0.24,
                                      flex: 14,
                                      child: Text(
                                        "From Date",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 1, child: Container()),
                                    Expanded(
                                      flex: 17,
//                                      width: size.width * 0.36,
                                      child: Text(
                                        "$fromDate",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 2, child: Container()),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
//                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(flex: 2, child: Container()),
                                    Expanded(
//                                      width: size.width * 0.24,
                                      flex: 14,
                                      child: Text(
                                        "To Date",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 1, child: Container()),
                                    Expanded(
                                      flex: 17,
//                                      width: size.width * 0.36,
                                      child: Text(
                                        "$toDate",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 2, child: Container()),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
//                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(flex: 2, child: Container()),
                                    Expanded(
//                                      width: size.width * 0.24,
                                      flex: 14,
                                      child: Text(
                                        "Extra Instructions",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 1, child: Container()),
                                    Expanded(
                                      flex: 17,
//                                      width: size.width * 0.36,
                                      child: Text(
                                        "$bookExtraInstructions",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 2, child: Container()),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
//                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(flex: 2, child: Container()),
                                    Expanded(
//                                      width: size.width * 0.24,
                                      flex: 14,
                                      child: Text(
                                        "Approval",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 1, child: Container()),
                                    Expanded(
                                      flex: 17,
//                                      width: size.width * 0.36,
                                      child: Text(
                                        "Pending",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 2, child: Container()),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 10,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.blueGrey,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
//                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(flex: 2, child: Container()),
                                    Expanded(
//                                      width: size.width * 0.24,
                                      flex: 14,
                                      child: Text(
                                        "Total Charges",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 1, child: Container()),
                                    Expanded(
                                      flex: 17,
//                                      width: size.width * 0.36,
                                      child: Text(
                                        "$total",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 2, child: Container()),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 0.0,
                            right: 0.0,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              },
                              child: Align(
                                alignment: Alignment.topRight,
                                child: CircleAvatar(
                                  radius: 14.0,
                                  backgroundColor: Colors.redAccent,
                                  child: Icon(Icons.close, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
    }

    showInternetIssueAlertDialog(BuildContext context) {
      AlertDialog alert = AlertDialog(
        title: Text(
          "Warning",
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        content: Text(
          "Connectivity issue, Please try again!",
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

    void addData(BuildContext context, Map<String, dynamic> lFetchData) {
      final Map<String, String> registerVal = {
        'total': total,
        'bookName': bookName,
        'bookPhoneNumber': bookPhoneNumber,
        'bookArea': bookArea,
        'bookExtraInstructions': bookExtraInstructions,
        'fromDate': fromDate,
        'toDate': toDate,
        'bookID': bookID,
        'workerID': workerID,
        'workerName': workerName,
        'workerCategory': workerCategory,
        'workerPhone': workerPhone,
        'workerCharges': workerCharges,
        'approval': "Pending",
      };

      http
          .post('$url/bookings.json',
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(registerVal))
          .then((http.Response response) {
        print(jsonDecode(response.body));
        print(response.statusCode);
        if (response.statusCode == 200) {
          showReceiptAlertDialog(context, lFetchData);
        } else {
          showInternetIssueAlertDialog(context);
        }
      });
    }

    showEmptyFromDateAlertDialog(BuildContext context) {
      AlertDialog alert = AlertDialog(
        title: Text(
          "Warning",
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        content: Text(
          "Kindly Choose From Date.",
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          FlatButton(
            child: Text("OK"),
            onPressed: () {
              setState(() {
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

    showEmptyToDateAlertDialog(BuildContext context) {
      // set up the button
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text(
          "Warning",
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        content: Text(
          "Kindly Choose To Date.",
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          FlatButton(
            child: Text("OK"),
            onPressed: () {
              setState(() {
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

    showToDateAlertDialog(BuildContext context) {
      // set up the button
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text(
          "Warning",
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        content: Text(
          "To Date should be greater than or equals to From Date",
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          FlatButton(
            child: Text("OK"),
            onPressed: () {
              setState(() {
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

    showFromDateAlertDialog(BuildContext context) {
      // set up the button
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text(
          "Warning",
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        content: Text(
          "From Date should be less than or equals to To-Date",
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          FlatButton(
            child: Text("OK"),
            onPressed: () {
              setState(() {
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

    void _presentFromDatePicker() {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
          DateTime.now().year,
        ),
        lastDate: DateTime(DateTime.now().year + 1),
      ).then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        bool c = false;
        DateTime check = pickedDate;
        if (selectedToDate == null || check.year < selectedToDate.year) {
          c = true;
        } else if (check.year == selectedToDate.year) {
          if (check.month < selectedToDate.month) {
            c = true;
          } else if (check.month == selectedToDate.month) {
            if (check.day <= selectedToDate.day) {
              c = true;
            }
          }
        }
        if (c == true) {
          setState(() {
            selectedFromDate = pickedDate;
            fromDate =
                '${selectedFromDate.day}/${selectedFromDate.month}/${selectedFromDate.year}';
          });
        } else {
          showFromDateAlertDialog(context);
        }
      });
    }

    void _presentToDatePicker() {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
          DateTime.now().year,
        ),
        lastDate: DateTime(DateTime.now().year + 1),
      ).then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        bool c = false;
        DateTime check = pickedDate;
        if (selectedFromDate == null || check.year > selectedFromDate.year) {
          c = true;
        } else if (check.year == selectedFromDate.year) {
          if (check.month > selectedFromDate.month) {
            c = true;
          } else if (check.month == selectedFromDate.month) {
            if (check.day >= selectedFromDate.day) {
              c = true;
            }
          }
        }
        if (c == true) {
          setState(() {
            selectedToDate = pickedDate;
            toDate =
                '${selectedToDate.day}/${selectedToDate.month}/${selectedToDate.year}';
          });
        } else {
          showToDateAlertDialog(context);
        }
      });
    }

    Widget buildBookFromDateField() {
      return Container(
        padding: EdgeInsets.only(top: 15),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              selectedFromDate == null ? 'No Date Chosen!' : fromDate,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            FlatButton(
              child: Text(
                'Choose From Date',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              textColor: Colors.lightBlue,
              padding: EdgeInsets.fromLTRB(9, 0, 9, 0),
              highlightColor: Colors.grey,
              onPressed: _presentFromDatePicker,
            ),
          ],
        ),
      );
    }

    Widget buildBookToDateField() {
      return Container(
        padding: EdgeInsets.only(top: 15),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              selectedToDate == null ? 'No Date Chosen!' : toDate,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            FlatButton(
              child: Text(
                'Choose To Date',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              textColor: Colors.lightBlue,
              padding: EdgeInsets.fromLTRB(9, 0, 9, 0),
              highlightColor: Colors.grey,
              onPressed: _presentToDatePicker,
            ),
          ],
        ),
      );
    }

    Widget buildPasswordField() {
      return TextFormField(
        decoration: InputDecoration(labelText: 'Password'),
        validator: (String value) {
          if (value.isEmpty) {
            return "Password is required.";
          }
          return null;
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

    showModalDialog(BuildContext context) {
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
          "Your details doesn't Exist, you have to create your account first!",
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          FlatButton(
            child: Text("OK"),
            onPressed: () {
              setState(() {
                Navigator.of(context).pop();
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
                Navigator.of(context).pop();
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
              color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        content: Text(
          "Logged in Successfully!",
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          FlatButton(
            child: Text("OK"),
            onPressed: () {
              setState(() {
                int difference =
                    selectedToDate.difference(selectedFromDate).inDays + 1;
                double t = difference * double.parse(workerCharges);
                total = t.toStringAsFixed(2);
                bookID = lFetchData['id'];
                bookName = lFetchData['name'];
                bookArea = lFetchData['area'];
                bookPhoneNumber = lFetchData['phoneNumber'];
                Navigator.of(context, rootNavigator: true).pop();
                Navigator.of(context, rootNavigator: true).pop();
                addData(context, lFetchData);
              });
            },
          )
          //  okButton,
        ],
      );

      http.get('$url/clients.json').then((http.Response response) {
        print('STATUS CODE: ' + (response.statusCode).toString());
        result = jsonDecode(response.body);
        setState(() {
          result.forEach((String ID, dynamic data) {
            final fdata = {
              'id': ID,
              'name': data['name'],
              'area': data['area'],
              'password': data['password'],
              'phoneNumber': data['phoneNumber'],
            };
            if (phoneNumber == data['phoneNumber']) {
              listFetchData = fdata;
            }
          });
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

    void SignInRequestModalSheet(BuildContext ctx) {
      setState(() {
        Future<void> future = showModalBottomSheet(
          context: ctx,
          isDismissible: true,
//      isScrollControlled: true,
          backgroundColor: Colors.white,
          builder: (_) {
            return GestureDetector(
              onTap: () {},
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/image/bluegradient.jpg"),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    color: Color.fromRGBO(255, 255, 255, 0.75),
                  ),
                  ListView(
                    children: [
                      Container(
                        padding: MediaQuery.of(context).viewInsets,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                            40,
                            40,
                            40,
                            20,
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Sign In",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Colors.black),
                                ),
                                SizedBox(height: 20),
                                buildPhoneField(),
                                buildPasswordField(),
                                SizedBox(height: 20),
                                AppButtons(
                                    title: "Sign In",
                                    textColor: Colors.white,
                                    buttonColor: Colors.lightBlue,
                                    press: () {
                                      setState(() {
                                        if (!_formKey.currentState.validate()) {
                                          return;
                                        }
                                        showModalDialog(context);
                                        _formKey.currentState.save();
                                      });
                                    }),
                                SizedBox(height: 30),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              behavior: HitTestBehavior.opaque,
            );
          },
        );
        future.then((_) {
//          setState(() {
//            lFetchData = fetchdata();
//          });
        });
      });
    }

    showAlertDialog(BuildContext context) {
      // set up the button
      // set up the AlertDialog
      if (selectedFromDate == null) {
        showEmptyFromDateAlertDialog(context);
        return;
      } else if (selectedToDate == null) {
        showEmptyToDateAlertDialog(context);
        return;
      }

      SignInRequestModalSheet(context);
    }

    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .35,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/image/bluegradient.jpg"),
              ),
            ),
          ),
          Container(
            height: size.height * .35,
            color: Color.fromRGBO(255, 255, 255, 0.30),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: size.height * .025),
            height: size.height * .35,
            width: double.infinity,
            child: Align(
              alignment: Alignment.center,
              child: AutoSizeText(
                "Book Us Now!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 50.0,
                  fontFamily: 'bold',
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(24, size.height * .35, 24, 0),
            child: ListView(
              children: <Widget>[
                Form(
                  key: _bookFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
//                      buildBookNameField(),
//                      buildBookPhoneField(),
//                      buildBookAreaField(),
//                      buildWorkerNameField(),
//                      buildWorkerCategoryField(),
//                      buildWorkerPhoneField(),
//                      buildWorkerChargesField(),
                      buildBookFromDateField(),
                      buildBookToDateField(),
                      buildExtraInstructionsField(),
                      SizedBox(height: 20),
                      AppButtons(
                          title: "SUBMIT",
                          buttonColor: Colors.lightBlue,
                          press: () {
                            if (!_bookFormKey.currentState.validate()) {
                              return;
                            }
                            _bookFormKey.currentState.save();
                            showAlertDialog(context);
                          }),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
