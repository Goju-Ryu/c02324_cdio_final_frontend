//*****************************************
//The contents of this file is based on the following entry in the Flutter cookbook
//https://flutter.dev/docs/cookbook/networking/fetch-data
//*****************************************


import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final routes = {
  '/': (BuildContext buildContext) => new HelloWorld()
};
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
      home: new Scaffold (
        appBar: AppBar(title: Text("Hello, World!"),),
        body: HelloWorld(title: "This is your message!")
      ),
    );
  }
}

class HelloWorld extends StatefulWidget {
  final String title;

  HelloWorld({Key key, this.title}) : super(key: key);

  @override
  _HelloWorldState createState() => _HelloWorldState();
}


class _HelloWorldState extends State<HelloWorld> {
  Future<Message> message;

  @override
  Widget build(BuildContext context){
    double c_width = MediaQuery.of(context).size.width*0.8; //80% width of screen

    return
    Container(
      width: c_width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(widget.title,
              style: TextStyle(
                  color: Colors.amberAccent,
                  fontSize: 36,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold
              )
          ),
          SizedBox(height: 50),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: _buildMessage(),
            ),
          )
        ],
      )
    );
  }
}


Widget _buildMessage() {
  return
  FutureBuilder<Message>(
    future: fetchMessage(),
    builder: (context, snapshot) {
       if (snapshot.hasError) {
         print(snapshot.error.toString());
        return Text(
          snapshot.error.toString(),
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              decoration: TextDecoration.none,
              color: Colors.red
          ),
        );
      } else if (snapshot.hasData) {
         print("Success");
         return Text(snapshot.data.msg);
       }

      //by default, show a loading spinner
       print("Loading");
      return CircularProgressIndicator();
    },
  );
}

Future<Message> fetchMessage() async{
  final response = await http.get(Uri.encodeFull('http://10.0.2.2:8080/rest/hello/1'),
        /*headers: {
          'Accept': 'Applications/json',
        },*///TODO: reimplement or delete
      );//The '10.0.2.2' is the address of the local host

  if (response.statusCode == 200) {
    //if server returns okay
    return Message.fromJson(json.decode(response.body));
  } else {
    //if response was not okay, throw an error
    print('Error in fetchMessage');
    print (response.body);
    throw Exception('Failed to load Message');
  }
}

class Message {
  final String msg;

  Message (this.msg);

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      json['msg'],
    );
  }
}
