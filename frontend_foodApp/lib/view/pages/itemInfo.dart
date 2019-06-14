import 'package:flutter/material.dart';


// main for testing
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
      home: Item(),
    );
  }
}

class Item extends StatelessWidget {
  void update() {
    //Todo: implement update
  }

  void delete() {
    //Todo: implement delete
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          Flexible(
            fit: FlexFit.tight,
            flex: 5,
            child:
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Smør'), //TODO add food_name getter
              Text('Mælkeprodukt'), //TODO add Category getter
              Text("2019-06-18"), //TODO add Exp_date getter
              Text('Skabet'), //TODO add location getter
            ],
          ),
          ),

          Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: MaterialButton( //BUTTON style
                child: Text('Update', style: TextStyle(fontSize: 36),),
                onPressed: update,
                textColor: Colors.red,
                splashColor: Colors.redAccent,
              color: Theme.of(context).accentColor,
              )),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: MaterialButton( // BUTTON STYLE
              child: Text('Delete', style: TextStyle(fontSize: 36),),
              onPressed: delete,
              textColor: Colors.red,
              splashColor: Colors.redAccent,
              color: Theme.of(context).accentColor,

          
            ),
          )
        ]);
  }
}
