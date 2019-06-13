import 'package:flutter/material.dart';
import 'package:frontend_flutter/util/TextStyles.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Text(
            "Home",
            style: MyHeadline,
          ),
          new Icon(Icons.home, size: screenWidth * 0.8, color: Colors.blueGrey,)
        ],
      ),
    );
  }
}