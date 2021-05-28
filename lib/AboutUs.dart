import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AboutUsPage extends StatefulWidget {
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
//    var size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        body: App(),
      ),
    );
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // var size = MediaQuery.of(context).size;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.45,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/image/bluegradient.jpg"),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * .45,
          color: Color.fromRGBO(255, 255, 255, 0.39),
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * .025,
              horizontal: 20),
          width: MediaQuery.of(context).size.width,
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AutoSizeText(
                  "ABOUT US",
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
//                      decoration: TextDecoration.underline,
                    fontSize: 29.0,
                    fontFamily: 'bold',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .025,
                ),
                AutoSizeText(
                  "An application that best offers you home services with just a knock. Now driver, maid, cook or a housekeeper, all are just a tap away!",
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
          height: double.infinity,
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(
              10, MediaQuery.of(context).size.height * .45, 10, 0),
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: AutoSizeText(
                  "MORE ABOUT US",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'bold',
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              Container(
                child: FAQ(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  bool one = false;
  bool two = false;
  bool three = false;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                setState(() {
                  if (one == false) {
                    one = true;
                  } else {
                    one = false;
                  }
                });
              },
              color: Colors.black.withOpacity(0.00),
              child: Text(
                "1. WHO WE ARE?                                                                                                 ",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              ),
              textColor: Colors.lightBlue,
              highlightColor: Colors.grey,
            ),
            one
                ? Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0),
                    child: Text(
                      "We are a group of four undergrad enthusiasts who aim to bring forth an" +
                          " application which offers easy solutions to daily-routine home chores. ",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  )
                : SizedBox(),

            //2
            FlatButton(
              onPressed: () {
                setState(() {
                  if (two == false) {
                    two = true;
                  } else {
                    two = false;
                  }
                });
              },
              color: Colors.black.withOpacity(0.00),
              child: Text(
                "2. WHAT WE DO?                                                                                                  ",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
              ),
              textColor: Colors.lightBlue,
              highlightColor: Colors.grey,
            ),
            two
                ? Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0),
                    child: Text(
                      "With creation of an user-friendly application, we offer easy access of booking and pre-booking of services that" +
                          " fulfils the customer's requirements. Services like that of maid, daycare, driver and cook are currently being" +
                          " catered.We wish to expand our range services soon!",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  )
                : SizedBox(),

            //3

            FlatButton(
              onPressed: () {
                setState(() {
                  three = three == true ? false : true;
                });
              },
              color: Colors.black.withOpacity(0.00),
              child: Text(
                "3. WHOM WE SERVE?                                                                                              ",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
              ),
              textColor: Colors.lightBlue,
              highlightColor: Colors.grey,
            ),
            three
                ? Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0),
                    child: Text(
                      "Our mission is to put forward easy access and solutions to daily chores for house wives, " +
                          "working women, aged people who often need quick and urgent services.",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  )
                : SizedBox(),
          ],
        ));
  }
}
