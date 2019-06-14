import 'package:flutter/material.dart';
//import 'package:flutter_web_test/flutter_web_test.dart';
//import 'package:flutter_web_ui/ui.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(body: CreateItem()),
    );
  }
}

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