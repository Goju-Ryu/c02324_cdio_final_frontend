import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:FoodTracker/util/foodDTO.dart';
import 'package:FoodTracker/rest/rest.dart' as rest;
import 'package:FoodTracker/util/stdColours.dart';
import 'package:FoodTracker/util/sharedStates.dart';
import 'package:FoodTracker/view/pages/createItem.dart';
import 'package:FoodTracker/view/popUp.dart';

import 'package:FoodTracker/view/pages/mainMenu.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  String stdUser = "TestUser";
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.top]);
    return MaterialApp(
      title: 'FoodTracker by Group14',

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
          primarySwatch: primaryColour,
          secondaryHeaderColor: secondaryColour),
      home:
        ChangeNotifierProvider(builder: (_) => AppState(stdUser), child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool needsNotification = true;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    popUp(appState, context);
    return Scaffold(
      appBar: AppBar(
        title: Text("FoodTracker by Group14"),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 31),
                child: FloatingActionButton(
                  child: Icon(Icons.home),
                  onPressed: () {
                    appState.selectPage(MainMenu());
                  },
                )),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              child: Icon(Icons.add_circle_outline),
              onPressed: () {
                appState.selectPage(CreateItem());
              },
            ),
          ),
        ],
      ),
      body: Column(children: [
        Flexible(flex: 1, child: appState.getPage()),
        SizedBox(
          height: 80,
          child: DecoratedBox(decoration: BoxDecoration(color: primaryColour)),
        ),
      ]),
    );
  }

  popUp(AppState appState, BuildContext context) async {
    if (needsNotification == true) {
      List<FoodDTO> isExpiring = await rest.getExpiredFood(
          appState.getUser(), appState.getNotificationSetting());
      print(isExpiring);
      if (isExpiring != null || isExpiring.length != 0) {
        PopNotification popNotification = PopNotification(isExpiring);
        popNotification.information(context);
        needsNotification = false;
      }
    }
  }
}
