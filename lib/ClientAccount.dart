import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'dart:convert';

import 'HomeScreen.dart';
import 'main.dart';

String url = 'https://knock-knock-f1915.firebaseio.com/';

class ClientAccount extends StatefulWidget {
  Map<String, dynamic> lFetchData;

  @override
  ClientAccount(this.lFetchData);

  _ClientAccountState createState() => _ClientAccountState(this.lFetchData);
}

class _ClientAccountState extends State<ClientAccount> {
  var top = 0.0;
  String cID;
  String cName;
  String phoneNumber;
  String password;
  Map<String, dynamic> clientData;

  _ClientAccountState(this.clientData) {
    cName = clientData['name'];
    cID = clientData['id'];
    phoneNumber = clientData['phoneNumber'];
    password = clientData['password'];
  }

  showAlertDialog(BuildContext context, int index) {
    AlertDialog alert = AlertDialog(
      title: Text(
        "Warning",
        style: TextStyle(
            color: Colors.redAccent, fontWeight: FontWeight.w500, fontSize: 20),
      ),
      content: Text(
        "Do you really want to delete this data?",
        style: TextStyle(color: Colors.grey),
      ),
      actions: [
        FlatButton(
          child: Text("YES"),
          onPressed: () {
            setState(() {
              Navigator.of(context, rootNavigator: true).pop();
              setState(() {
                deleteData(index);
              });
            });
          },
        ),
        FlatButton(
          child: Text("NO"),
          onPressed: () {
            setState(() {
              Navigator.of(context, rootNavigator: true).pop();
              lFetchData = fetchdata();
            });
          },
        )
        //  okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void deleteData(int index) {
    final String val = lFetchData[index]['id'];
    lFetchData.removeAt(index);
    http.delete('${url}/bookings/${val}.json').then((http.Response response) {
      print(response.body);
    });
  }

  List<Map<String, dynamic>> lFetchData;

  List<Map<String, dynamic>> fetchdata() {
    List<Map<String, dynamic>> listFetchData = [];
    Map<String, dynamic> result;
    http.get('${url}/bookings.json').then((http.Response response) {
      result = jsonDecode(response.body);
      setState(() {
        print(response.statusCode);
        result.forEach((String ID, dynamic data) {
          final Map<String, String> fdata = {
            'id': ID,
            'total': data['total'],
            'bookName': data['bookName'],
            'bookPhoneNumber': data['bookPhoneNumber'],
            'bookArea': data['bookArea'],
            'bookExtraInstructions': data['bookExtraInstructions'],
            'fromDate': data['fromDate'],
            'toDate': data['toDate'],
            'bookID': data['bookID'],
            'workerID': data['workerID'],
            'workerName': data['workerName'],
            'workerCategory': data['workerCategory'],
            'workerPhone': data['workerPhone'],
            'workerCharges': data['workerCharges'],
            'approval': data['approval'],
          };
          print(data['bookID']);
          if (cID == data['bookID']) {
            listFetchData.add(fdata);
          }
        });
      });
    });
    return listFetchData;
  }

  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.redAccent,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  initState() {
    lFetchData = fetchdata();
    super.initState();
  }

  _onBackPressed() {
    AlertDialog alert = AlertDialog(
      title: Text(
        "Are you sure?",
        style: TextStyle(
            color: Colors.redAccent, fontWeight: FontWeight.w500, fontSize: 20),
      ),
      content: Text(
        "Do you want to sign out?",
        style: TextStyle(color: Colors.grey),
      ),
      actions: [
        FlatButton(
          child: Text("YES"),
          onPressed: () {
            setState(() {
              Navigator.of(context, rootNavigator: true).popUntil((route) => route.isFirst);
//              Navigator.of(context, rootNavigator: true).popUntil((route) => route.isFirst);
            });
          },
        ),
        FlatButton(
          child: Text("NO"),
          onPressed: () {
            setState(() {
              Navigator.of(context, rootNavigator: true).pop();
            });
          },
        )
        //  okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blueAccent,
        errorColor: Colors.redAccent,
      ),
      home: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
//                backgroundColor: Colors.blue,
                expandedHeight: 200.0,
                floating: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        lFetchData = fetchdata();
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.power_settings_new,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _onBackPressed();
                    },
                  ),
                ],
//              leading:
                pinned: true,
                flexibleSpace: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  // print('constraints=' + constraints.toString());
                  top = constraints.biggest.height;
                  return FlexibleSpaceBar(
                    title: Text(
                      "${cName} \n($phoneNumber)",
                      textAlign: TextAlign.start,
                    ),
                    background: Image.asset(
                      "assets/image/bluegradient.jpg",
                      color: Color.fromRGBO(255, 255, 255, 0.75),
                      colorBlendMode: BlendMode.modulate,
                      fit: BoxFit.cover,
                    ),
                  );
                }),
              ),
            ];
          },
          body: Align(
            alignment: Alignment.topLeft,
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return Dismissible(
                  background: stackBehindDismiss(),
                  key: ObjectKey(lFetchData[index]),
                  onDismissed: (direction) {
                    showAlertDialog(context, index);
                  },
                  child: Card(
                    borderOnForeground: true,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.blueAccent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    margin: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 5,
                    ),
                    elevation: 5,
                    child: Container(
                      margin: EdgeInsets.all(0),

//                      decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(35.0),
//                        image: DecorationImage(
//                          fit: BoxFit.fill,
//                          image: AssetImage("assets/image/bluegradient.jpg"),
//                        ),
//                      ),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35.0),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [Colors.blueAccent, Colors.redAccent],
                        ),
                      ),

                      child: Container(
                        color: Color.fromRGBO(255, 255, 255, 0.8),
                        child: ListTile(
                          //list tile is another option instad of card, leading is the first thing,
//                  circle avatar is the round widget, mostly used for image

                          title: Container(
                            child: SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: <Widget>[
//                                    Padding(
//                                      padding: EdgeInsets.only(bottom: 10),
//                                      child: Column(
//                                        children: <Widget>[
//                                          SizedBox(
//                                            width: MediaQuery.of(context)
//                                                .copyWith()
//                                                .size
//                                                .width,
//                                            child: Text(
//                                              'CLIENT NAME',
//                                              style: TextStyle(
//                                                fontWeight: FontWeight.bold,
//                                                color: Colors.blueAccent,
//                                              ),
//                                            ),
//                                          ),
//                                          SizedBox(
//                                            width: double.infinity,
//                                            child: Text(
//                                              '${lFetchData[index]['bookName']}',
//                                            ),
//                                          ),
//                                        ],
//                                      ),
//                                    ),
//                                    Padding(
//                                      padding: EdgeInsets.only(bottom: 10),
//                                      child: Column(
//                                        children: <Widget>[
//                                          SizedBox(
//                                            width: MediaQuery.of(context)
//                                                .copyWith()
//                                                .size
//                                                .width,
//                                            child: Text(
//                                              'CLIENT PHONE NO',
//                                              style: TextStyle(
//                                                color: Colors.blueAccent,
//                                                fontWeight: FontWeight.bold,
//                                              ),
//                                            ),
//                                          ),
//                                          SizedBox(
//                                            width: double.infinity,
//                                            child: Text(
//                                              '${lFetchData[index]['bookPhoneNumber']}',
//                                            ),
//                                          ),
//                                        ],
//                                      ),
//                                    ),
//                                    Padding(
//                                      padding: EdgeInsets.only(bottom: 10),
//                                      child: Column(
//                                        children: <Widget>[
//                                          SizedBox(
//                                            width: MediaQuery.of(context)
//                                                .copyWith()
//                                                .size
//                                                .width,
//                                            child: Text(
//                                              'CLIENT ADDRESS',
//                                              style: TextStyle(
//                                                color: Colors.blueAccent,
//                                                fontWeight: FontWeight.bold,
//                                              ),
//                                            ),
//                                          ),
//                                          SizedBox(
//                                            width: double.infinity,
//                                            child: Text(
//                                              '${lFetchData[index]['bookArea']}',
//                                            ),
//                                          ),
//                                        ],
//                                      ),
//                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              'WORKER NAME',
                                              style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              '${lFetchData[index]['workerName']}',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              'WORKER CATEGORY',
                                              style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              '${lFetchData[index]['workerCategory']}',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              'WORKER PHONE',
                                              style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              '${lFetchData[index]['workerPhone']}',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .copyWith()
                                                .size
                                                .width,
                                            child: Text(
                                              'FROM DATE',
                                              style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              '${lFetchData[index]['fromDate']}',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .copyWith()
                                                .size
                                                .width,
                                            child: Text(
                                              'TO DATE',
                                              style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              '${lFetchData[index]['toDate']}',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              'CHARGES (PER DAY)',
                                              style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              '${lFetchData[index]['workerCharges']}',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .copyWith()
                                                .size
                                                .width,
                                            child: Text(
                                              'TOTAL CHARGES',
                                              style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              '${lFetchData[index]['total']}',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              'EXTRA INSTRUCTIONS',
                                              style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              '${lFetchData[index]['bookExtraInstructions']}',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              'APPROVAL',
                                              style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              '${lFetchData[index]['approval']}',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: lFetchData.length,
            ),
          ),
        ),
//        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//        floatingActionButton: FloatingActionButton(
//          child: Icon(
//            Icons.add,
//          ),
//          onPressed: () {
//          },
//        ),
      ),
    );
  }
}
