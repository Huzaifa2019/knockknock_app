import 'package:flutter/material.dart';
import './AboutUs.dart';
import './Buttonsfile.dart';
import './JoinUs.dart';
import './ContactUs.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.01),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BottomNavBar(
              title: "About Us",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return AboutUsPage();
                  }),
                );
              }),
          BottomNavBar(
            title: "Join Us",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return JoinUsScreen();
                }),
              );
            },
          ),
          BottomNavBar(
              title: "Contact Us",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return Contact();
                  }),
                );
              }),
        ],
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final String title;
  final Function press;

  const BottomNavBar({
    Key key,
    this.title,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        AppButtons(
          title: title,
          buttonColor: Colors.lightBlue,
          press: press,
        ),
      ],
    );
  }
}
