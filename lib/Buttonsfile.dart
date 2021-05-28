import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButtons extends StatelessWidget {
  final Color buttonColor;
  final String title;
  final Function press;
  Color textColor = null;

  AppButtons({
    Key key,
    this.textColor,
    @required this.title,
    this.buttonColor,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.32,
      child: RaisedButton(
        onPressed: press,
        textColor: textColor == null ? Colors.white : textColor,
        elevation: 12,
        highlightColor: Colors.white70,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        color: buttonColor,
        child: FittedBox(
          child: Text(
            title,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
