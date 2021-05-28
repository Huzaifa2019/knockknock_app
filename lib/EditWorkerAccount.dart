import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

String url = 'https://knock-knock-f1915.firebaseio.com/';

String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
  if (value.length != 12)
    return 'Please note the pattern';
  else
    return null;
}

class EditWorkerAccount extends StatefulWidget {
  String id;
  String total;
  String bookName;
  String bookPhoneNumber;
  String bookArea;
  String bookExtraInstructions;
  String fromDate;
  String toDate;
  String bookID;
  String workerID;
  String workerName;
  String workerCategory;
  String workerPhone;
  String workerCharges;
  String approval;

  EditWorkerAccount({
    @required this.id,
    @required this.total,
    @required this.bookName,
    @required this.bookPhoneNumber,
    @required this.bookArea,
    @required this.bookExtraInstructions,
    @required this.fromDate,
    @required this.toDate,
    @required this.bookID,
    @required this.workerID,
    @required this.workerName,
    @required this.workerCategory,
    @required this.workerPhone,
    @required this.workerCharges,
    @required this.approval,
  });

  @override
  _EditWorkerAccountState createState() => _EditWorkerAccountState(
        id: id,
        total: total,
        bookName: bookName,
        bookPhoneNumber: bookPhoneNumber,
        bookArea: bookArea,
        bookExtraInstructions: bookExtraInstructions,
        fromDate: fromDate,
        toDate: toDate,
        bookID: bookID,
        workerID: workerID,
        workerName: workerName,
        workerCategory: workerCategory,
        workerPhone: workerPhone,
        workerCharges: workerCharges,
        approval: approval,
      );
}

class _EditWorkerAccountState extends State<EditWorkerAccount> {
  String id;
  String total;
  String bookName;
  String bookPhoneNumber;
  String bookArea;
  String bookExtraInstructions;
  String fromDate;
  String toDate;
  String bookID;
  String workerID;
  String workerName;
  String workerCategory;
  String workerPhone;
  String workerCharges;
  String approval;
  String approvalDropDown;

  _EditWorkerAccountState({
    @required this.id,
    @required this.total,
    @required this.bookName,
    @required this.bookPhoneNumber,
    @required this.bookArea,
    @required this.bookExtraInstructions,
    @required this.fromDate,
    @required this.toDate,
    @required this.bookID,
    @required this.workerID,
    @required this.workerName,
    @required this.workerCategory,
    @required this.workerPhone,
    @required this.workerCharges,
    @required this.approval,
  }) {
    approvalDropDown = this.approval;
  }

  @override
  showAlertDialog(BuildContext context) {
    // set up the button
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Congratulations",
        style: TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.w500,
            fontSize: 20),
      ),
      content: Text(
        "Approval updated successfully.",
        style: TextStyle(color: Colors.grey),
      ),
      actions: [
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.of(context, rootNavigator: true).pop();
//            Navigator.of(context).pop();
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

  void updateData({
    String id,
    String total,
    String bookName,
    String bookPhoneNumber,
    String bookArea,
    String bookExtraInstructions,
    String fromDate,
    String toDate,
    String bookID,
    String workerID,
    String workerName,
    String workerCategory,
    String workerPhone,
    String workerCharges,
    String approval,
  }) {
    final Map<String, String> registerVal = {
      'id': id,
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
      'approval': approval,
    };

    http
        .put('$url/bookings/${id}.json',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(registerVal))
        .then((http.Response response) {
//      print(jsonDecode(response.body));
      showAlertDialog(context);
    });
//    print(registerVal);
  }

  var ValidateKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    // TODO: implement build
    return new Form(
      key: ValidateKey,
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
          Container(
            padding: MediaQuery.of(context).viewInsets,
            child: ListView(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 40),
                ),
                Container(
//            padding: const EdgeInsets.only(top: 40, bottom: 40),
                  // color: Colors.blue,
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 300,
                              child: Text(
                                "Choose Approval\n(Pending / Approved / Rejected)",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              width: 130,
                              child: Text(
                                "Approval",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: DropdownButton<String>(
                                value: approvalDropDown,
                                //hint: Text('Select Category   '),
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                onChanged: (String newValue) {
                                  approval = newValue;
                                  setState(() {
                                    approvalDropDown = newValue;
                                  });
                                },
                                items: <String>[
                                  'Pending',
                                  'Approved',
                                  'Rejected',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            )
                          ],
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              Text('\n\n'),
                              RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    if (ValidateKey.currentState.validate()) {
                                      updateData(
                                        id: id,
                                        total: total,
                                        bookName: bookName,
                                        bookPhoneNumber: bookPhoneNumber,
                                        bookArea: bookArea,
                                        bookExtraInstructions:
                                            bookExtraInstructions,
                                        fromDate: fromDate,
                                        toDate: toDate,
                                        bookID: bookID,
                                        workerID: workerID,
                                        workerName: workerName,
                                        workerCategory: workerCategory,
                                        workerPhone: workerPhone,
                                        workerCharges: workerCharges,
                                        approval: approval,
                                      );
                                    }
                                  });
                                },
                                child: Text(
                                  'UPDATE',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                                textColor: Colors.white,
                                padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                                highlightColor: Colors.grey,
                                color: Colors.blueAccent,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 40),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
