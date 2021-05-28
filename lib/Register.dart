import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:motion_tab_bar/MotionTabBarView.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/motiontabbar.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import './WorkerJoin.dart';
import './WorkerSignIn.dart';
import './ClientJoin.dart';
import './ClientSignIn.dart';
//import 'package:flutter_form_builder/flutter_form_builder.dart';

import './Buttonsfile.dart';

class JoinUsForm extends StatefulWidget {
  bool login;

  JoinUsForm({this.login = false});

  @override
  _JoinUsFormState createState() => _JoinUsFormState(this.login);
}

class _JoinUsFormState extends State<JoinUsForm> {
  bool login;

  _JoinUsFormState(this.login);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Tabs(login: login),
    );
  }
}

class Tabs extends StatefulWidget {
  bool login;

  Tabs({Key key, @required this.login}) : super(key: key);

  @override
  _TabsState createState() => _TabsState(login);
}

class _TabsState extends State<Tabs> with TickerProviderStateMixin {
  MotionTabController _tabController;
  bool login = false;

  _TabsState(this.login);

  @override
  void initState() {
    int i = 0;
    if (login == true) {
      i = 1;
    }
    super.initState();
    _tabController =
        MotionTabController(initialIndex: i, length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MotionTabBar(
        labels: ["Sign Up", "Sign In"],
        initialSelectedTab: (login == false) ? "Sign Up" : "Sign In",
        tabIconColor: Colors.blueAccent,
        tabSelectedColor: Colors.blue,
        onTabItemSelected: (int value) {
          print(value);
          setState(() {
            _tabController.index = value;
          });
        },
        icons: [Icons.add, Icons.person],
        textStyle: TextStyle(color: Colors.blue),
      ),
      body: MotionTabBarView(
        controller: _tabController,
        children: <Widget>[
          Join(),
          SignIn(login: login),
        ],
      ),
    );
  }
}

class Join extends StatefulWidget {
  @override
  _JoinState createState() => _JoinState();
}

bool joinState = true;

class _JoinState extends State<Join> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        Container(
//          padding: EdgeInsets.only(top:10),
          height: size.height * .30,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/image/bluegradient.jpg"),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: size.height * .025),
          color: Color.fromRGBO(255, 255, 255, 0.30),
          height: size.height * .30,
          width: double.infinity,
          child: Align(
            alignment: Alignment.center,
            child: AutoSizeText(
              "Join Us Now!",
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
          margin: EdgeInsets.fromLTRB(24, size.height * .30, 24, 0),
          child: ListView(
            children: <Widget>[
              Container(
                width: size.width,
                alignment: Alignment.center,
                child: Wrap(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Colors.white70,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: LiteRollingSwitch(
                        value: true,
                        textOn: 'Worker',
                        textOff: 'Client',
                        colorOn: Colors.blueAccent,
                        colorOff: Colors.lightBlue,
                        iconOn: Icons.work,
                        iconOff: Icons.person,
                        onChanged: (bool state) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              joinState = state;
                            }); // Add Your Code here.
                          });
                          print('turned ${(state) ? 'on' : 'off'}');
                        },
                      ),
                    ),
                  ],
                ),
              ),
              (joinState == true) ? WorkerJoin() : ClientJoin(),
            ],
          ),
        ),
      ],
    );
  }
}

class SignIn extends StatefulWidget {
  bool login = false;

  SignIn({this.login});

  @override
  _SignInState createState() => _SignInState(login: login);
}

class _SignInState extends State<SignIn> {
  @override
  bool login;
  bool signInState = true;

  _SignInState({this.login}) {
    signInState = (login == false) ? true : false;
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        Container(
//          padding: EdgeInsets.only(top:10),
          height: size.height * .30,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/image/bluegradient.jpg"),
            ),
          ),
        ),
        Container(
          color: Color.fromRGBO(255, 255, 255, 0.30),
          padding: EdgeInsets.symmetric(vertical: size.height * .025),
          height: size.height * .30,
          width: double.infinity,
          child: Align(
            alignment: Alignment.center,
            child: AutoSizeText(
              "Sign In",
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
          margin: EdgeInsets.fromLTRB(24, size.height * .30, 24, 0),
          child: ListView(
            children: <Widget>[
              Container(
                width: size.width,
                alignment: Alignment.center,
                child: Wrap(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Colors.white70,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: LiteRollingSwitch(
                        value: (login == false) ? true : false,
                        textOn: 'Worker',
                        textOff: 'Client',
                        colorOn: Colors.blueAccent,
                        colorOff: Colors.lightBlue,
                        iconOn: Icons.work,
                        iconOff: Icons.person,
                        onChanged: (bool state) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              signInState = state;
                            }); // Add Your Code here.
                          });
                          print('turned ${(state) ? 'on' : 'off'}');
                        },
                      ),
                    ),
                  ],
                ),
              ),
              (signInState == true) ? WorkerSignIn() : ClientSignIn(),
            ],
          ),
        ),
      ],
    );
  }
}
