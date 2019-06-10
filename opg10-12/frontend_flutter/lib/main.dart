import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      home: HelloWorld(title: "This is your message!"),
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
    double c_width = MediaQuery.of(context).size.width*0.8; //width of screen

    return
    Container(
      width: c_width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(widget.title, style: TextStyle(color: Colors.amberAccent, decoration: TextDecoration.none)),
          SizedBox(height: 50),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: _buildMessage(),
            )
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
         return Text(snapshot.data.msg);
       }

      //by default, show a loading spinner
      return CircularProgressIndicator();
    },
  );
}

Future<Message> fetchMessage() async{
  final response = await http.get('http://10.0.2.2:8080');//The '10.0.2.2' is the address of the local host

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
      json['message'],
    );
  }
}
