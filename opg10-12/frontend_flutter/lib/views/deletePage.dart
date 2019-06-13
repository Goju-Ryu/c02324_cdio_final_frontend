import 'package:flutter/material.dart';

import 'package:frontend_flutter/rest.dart' as rest;

import 'package:frontend_flutter/styles/TextStyles.dart';


class DeletePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text("Delete Food", style: MyHeadline),
          new Row(
            children: [
              //TODO: insert the elements needed to delete
            ]
          )
        ],
      ),
    );
  }
}