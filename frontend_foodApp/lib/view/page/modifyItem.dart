import 'package:flutter/material.dart';

import 'stdColours.dart';
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
      home: ModifyItem(),
    );
  }
}

class ModifyItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        //Change name
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
            child: MaterialButton(
                onPressed: () => _createDialog(context, "Change name", "SampleName"/*TODO add getter for starting content (name)*/),
              color: secondaryColour,
              splashColor: btnSplashColour,
              highlightColor: btnHighlightColour,
              disabledColor: btnDisabledColour,
              child: Text(
                'Salmon'
              ),
            ),
        ),
        //Change Category
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: MaterialButton(
            onPressed: () => _createDialog(context, "Change category", "SampleCategory"/*TODO add getter for starting content (category)*/),
            color: secondaryColour,
            splashColor: btnSplashColour,
            highlightColor: btnHighlightColour,
            disabledColor: btnDisabledColour,
            child: Text(
                'Fish'
            ),
          ),
        ),
        //Change expDate
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: MaterialButton(
            onPressed: () => _createDialog(context, "Change expiration date", "SampleDate"/*TODO add getter for starting content (date)*/),
            color: secondaryColour,
            splashColor: btnSplashColour,
            highlightColor: btnHighlightColour,
            disabledColor: btnDisabledColour,
            child: Text(
                '17/06/2019'
            ),
          ),
        ),
        //Change Location
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: MaterialButton(
            onPressed: () => _createDialog(context, "Change location", "SampleLocation"/*TODO add getter for starting content (location)*/),
            color: secondaryColour,
            splashColor: btnSplashColour,
            highlightColor: btnHighlightColour,
            disabledColor: btnDisabledColour,
            child: Text(
                'Hello World!'
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: MaterialButton(
            onPressed: () => _createDialog(context, "Delete", "SampleDelete"/*TODO add deletion method*/),
            color: secondaryColour,
            splashColor: btnSplashColour,
            highlightColor: btnHighlightColour,
            disabledColor: btnDisabledColour,
            child: Text(
                'Goodbye World!'
            ),
          ),
        ),
      ],
    );
  }

  _createDialog(BuildContext context, String title, String startContent){
    showDialog(context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text(title),
        content: TextField(
          decoration: InputDecoration(
              hintText: startContent,
          ),
          autofocus: true,
        ),
        actions: <Widget>[
          MaterialButton(
              onPressed: () {
//TODO add saving of data
                Navigator.of(context).pop();
              },
              child: Text("Confirm"),
          )
        ],
      );
    }
    );
  }
}
