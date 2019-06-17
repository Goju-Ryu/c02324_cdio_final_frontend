import 'package:flutter/material.dart';
import 'package:semester2_cdio_final/util/buttonStyles.dart';
import 'package:semester2_cdio_final/util/stdColours.dart';

import 'package:semester2_cdio_final/view/page/mainMenu.dart';
import 'package:semester2_cdio_final/view/page/createItem.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food app - demo',
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
          //primarySwatch: primaryColour,
          //secondaryHeaderColor: secondaryColour
          ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  EPages _selection = EPages.mainMenu;

  void _selectPage(EPages selection) {
    setState(() {
      _selection = selection;
    });
  }

  Widget _getPage() {
    switch (this._selection) {
      case EPages.mainMenu:
        return MainMenu();


      case EPages.itemList:
        // TODO: Handle this case.
        break;
      case EPages.createItem:
        return CreateItem();

      case EPages.itemView:
        // TODO: Handle this case.
        break;
      case EPages.updateItem:
        // TODO: Handle this case.
        break;
      default:
        return Text("Page selection failed: index [" +
            this._selection.index.toString() +
            "] is unknown");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food app - demo"),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 31),
                child: FloatingActionButton(
                  child: Icon(Icons.home),
                  onPressed: () {_selectPage(EPages.mainMenu);},
                )
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              child: Icon(Icons.add_circle_outline),
              onPressed: () {_selectPage(EPages.createItem);},
            ),
          ),
        ],
      ),
      body: _getPage(),
    );;
  }
}

enum EPages { mainMenu, itemList, createItem, itemView, updateItem }
