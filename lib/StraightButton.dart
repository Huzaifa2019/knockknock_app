import 'package:flutter/material.dart';

class PlainButton extends StatelessWidget {
  final String title;
  final Function press;
  final Color buttonColor;

  const PlainButton({
    Key key,
    this.title,
    this.press,
    this.buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: <Widget>[
            Text(title,
                style: TextStyle(
                  color: buttonColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                )),
            Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                height: 3,
                width: 22,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                )),
          ],
        ),
      ),
    );
  }
}
