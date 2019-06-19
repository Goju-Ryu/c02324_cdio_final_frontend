import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester2_cdio_final/util/sharedStates.dart';
import 'package:semester2_cdio_final/util/stdColours.dart';
import 'package:semester2_cdio_final/view/pages/createItem.dart';
import 'package:semester2_cdio_final/view/pages/mainMenu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  String stdUser = "Pur";

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
          secondaryHeaderColor: secondaryColour),
      home: MultiProvider(child: MyHomePage(), providers: [
        ChangeNotifierProvider(builder: (_) => AppState(stdUser)),
//        ChangeNotifierProvider(
//            builder: (_) => FoodList.dummyList()),//restList(stdUser)), //Use '.dummyList()' instead of '.restList(stdUser)' to use a list of data with no need for the rest service
      ]),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
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
}
