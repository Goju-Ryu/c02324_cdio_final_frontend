import 'package:flutter/material.dart';

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
      home: MainMenu(),
    );
  }
}

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: MaterialButton(
            child: Text(
              "Freezer",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40
              ),
            ),
            onPressed: () {}/*TODO add method to link to Freezer page*/,
            color: Theme.of(context).accentColor,
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: MaterialButton(
            child: Text(
              "Refrigerator",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
              ),
            ),
            onPressed: () {}/*TODO: Add method to link to fridge page*/,
            color: Theme.of(context).accentColor,
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: MaterialButton(
            child: Text(
              "Pantry",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40
              ),
            ),
            onPressed: () {}/*TODO: Add method to link to pantry page*/,
            color: Theme.of(context).accentColor,
          ),
        ),
      ],
    );
  }
}
