import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CategoryCard extends StatelessWidget {
  final String imgSrc;
  final String title;
  final Function press;

  const CategoryCard({
    Key key,
    this.imgSrc,
    this.title,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blueGrey,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: press,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: <Widget>[
                  Spacer(),
                  FittedBox(
                    fit: BoxFit.fill,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          alignment: Alignment.center,
                          fit: BoxFit.fill,
                          image: AssetImage(imgSrc),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    child: AutoSizeText(title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.title.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
