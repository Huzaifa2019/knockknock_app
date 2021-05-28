import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import './CardLists.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './BookNow.dart';
import 'Register.dart';

String url = 'https://knock-knock-f1915.firebaseio.com/';

class MaidScreen extends StatefulWidget {
  @override
  _MaidScreenState createState() => _MaidScreenState();
}

class _MaidScreenState extends State<MaidScreen> {
  List<Map<String, dynamic>> lFetchData;

  List<Map<String, dynamic>> fetchdata() {
    List<Map<String, dynamic>> listFetchData = [];
    Map<String, dynamic> result;
    http.get('$url/workers.json').then((http.Response response) {
      result = jsonDecode(response.body);
      print('STATUS CODE: ' + (response.statusCode).toString());
      setState(() {
        result.forEach((String ID, dynamic data) {
          final fdata = {
            'id': ID,
            'name': data['name'],
            'age': data['age'],
            'area': data['area'],
            'experience': data['experience'],
            'charges': data['charges'],
            'phoneNumber': data['phoneNumber'],
          };
          if (data['category'] == "Maid") {
            listFetchData.add(fdata);
          }
        });
      });
    });
    return listFetchData;
  }

  initState() {
    lFetchData = fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    DecorationImage Dec() {
      return DecorationImage(
        fit: BoxFit.fill,
        image: AssetImage("assets/image/maasi.jpg"),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        actions: [
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
//            color: Colors.white,
          ),
          IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return JoinUsForm(
                    login: true,
                  );
                }),
              );
            },
//            color: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .25,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/image/maasi.jpg"),
              ),
            ),
          ),
          Container(
            height: size.height * .25,
            padding: EdgeInsets.only(left: 10, bottom: 5),
            color: Color.fromRGBO(255, 255, 255, 0.59),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: AutoSizeText(
                'MAID',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 50.0,
                    fontFamily: 'bold',
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                    backgroundColor: Colors.white70),
              ),
            ),
          ),
          Container(
            height: size.height,
            padding: EdgeInsets.only(
              top: size.height * 0.25,
              left: 10,
              right: 10,
//              bottom: 10,
            ),
            child: ListView.builder(
              itemBuilder: (BuildContext context, index) {
                return ListNames(
                    dec: Dec(),
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return BookNowForm(
                              workerName: lFetchData[index]['name'],
                              workerCategory: 'Maid',
                              workerPhone: lFetchData[index]['phoneNumber'],
                              workerCharges: lFetchData[index]['charges'],
                              workerID: lFetchData[index]['id'],
                            );
                          },
                        ),
                      );
                    },
                    name: lFetchData[index]['name'],
                    age: lFetchData[index]['age'],
                    location: lFetchData[index]['area'],
                    exp: lFetchData[index]['experience'],
                    charges: lFetchData[index]['charges'],
                    buttonColors: Colors.purple);
              },
              itemCount: lFetchData.length,
            ),
          ),
        ],
      ),
    );
  }
}
