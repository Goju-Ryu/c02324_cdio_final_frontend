import 'package:flutter/material.dart';
//import 'package:flutter_web_test/flutter_web_test.dart';
//import 'package:flutter_web_ui/ui.dart';

class CreateItem extends StatelessWidget{
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Flexible(
    fit: FlexFit.tight,
        flex: 5,
        child:
        Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField( decoration: InputDecoration(
                  labelText: "Name Food")),
              TextFormField( decoration: InputDecoration( //TODO replace with choice menu
                  labelText: "Place Food")),
              TextFormField( decoration: InputDecoration( //TODO replace with choice menu
                  labelText: "Cat Food")),
              TextFormField( decoration: InputDecoration( // TODO replace with scrolling date
                  labelText: "Date Food")),
              SizedBox(height: 30),
              RaisedButton(
                onPressed: () {},
                child: const Text(
                    'Send',
                    style: TextStyle(fontSize: 20)
                ),
              ),
            ]
        ),
        ),
      ],
    );
  }
}