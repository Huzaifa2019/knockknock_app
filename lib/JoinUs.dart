import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'Buttonsfile.dart';
import 'Register.dart';

class JoinUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
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
            color: Color.fromRGBO(255, 255, 255, 0.39),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .60,
                  width: MediaQuery.of(context).size.width,
                  child: AutoSizeText(
                    "Do you wish to make your leisure time fruitful?Are you seeking comfortable access to work?Then you are at the right door!\n\nKnock at our door by signing up with us and offer services to the ones who seek it.\n\nLet's bring more of what this world needs, let's join hands to offer help and care.",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'bold',
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
//                      maxLines: 2,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.1,
                    minHeight: MediaQuery.of(context).size.height * 0.06,
                  ),
                  height: 35,
                  child: AppButtons(
                    title: "Join here!",
                    textColor: Colors.blue,
                    buttonColor: Colors.white,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return JoinUsForm(
                            login: false,
                          );
                        }),
                      );
                    },
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
