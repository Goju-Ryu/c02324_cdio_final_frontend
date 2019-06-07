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
      home: HelloWorld(),
    );
  }
}

class HelloWorld extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Message>(
      future: fetchMessage(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data.msg);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        //by default, show a loading spinner
        return CircularProgressIndicator();
      },
    );
  }
}







Future<Message> fetchMessage() async{
  final response = await http.get('http://localhost:8080/rest/hello');

  if (response.statusCode == 200) {
    //if server returns okay
    return Message.fromJson(json.decode(response.body));
  } else {
    //if response was not okay, throw an error
    print("error in fetchMessage");
    throw Exception('Failed to load Message');
  }
}

class Message {
  final String msg;

  Message ({this.msg});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      msg: json['msg']
    );
  }
}
