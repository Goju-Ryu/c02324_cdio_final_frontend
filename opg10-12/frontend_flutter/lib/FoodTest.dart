import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_flutter/rest.dart' as rest;

void main() => runApp(new MyApp());

///Root of the app determining which view to be shown.
class MyApp extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      title: "Proof of concept food app",
      home: new Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home>{
  _EWindow _selection = _EWindow.home;

  void _select(int i){
    setState(() {
      _selection = _EWindow.values[i];
    });
  }

  Widget _getWindow () {
    switch (_selection) {
      case (_EWindow.home): {
        return new HomePage();
      }
      case (_EWindow.getFood): {
        return new GetPage();
      }
      case (_EWindow.updateFood): {
        return new UpdatePage();
      }
      case (_EWindow.deleteFood): {
        return new DeletePage();
      }
      default: {
        throw new Exception("Home: _getWindow: unknown selection (_selection)");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      new Scaffold(
        appBar: new AppBar(
          title: new Text("Food App"),
        ),
        bottomNavigationBar: new BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home"),),
            BottomNavigationBarItem(icon: Icon(Icons.fastfood), title: Text("Get"),),
            BottomNavigationBarItem(icon: Icon(Icons.update), title: Text("Update"),),
            BottomNavigationBarItem(icon: Icon(Icons.delete), title: Text("Delete"),),
          ],
          unselectedItemColor: Colors.lightBlue,
          selectedItemColor: Colors.blue,
          currentIndex: _selection.index,
          onTap: _select,
        ),
        body: _getWindow(),
      );
  } // build
}// class



class HomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Text(
            "Home",
            style: MyHeadline,
          ),
          new Icon(Icons.home, size: screenWidth * 0.8, color: Colors.blueGrey,)
        ],
      ),
    );
  }
}


class UpdatePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Text("Update Food");
  }
}

class DeletePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Text("Delete Food");
  }
}

class GetPage extends StatefulWidget{
  @override
  _GetPageState createState() => new _GetPageState();
}

class _GetPageState extends State<GetPage> {
  bool _getList = true;

  void setGetList(bool b) {
    setState(() {
      _getList = b;
    });
  }

  void search() {
    //todo: use the rest search function
  }

  @override
  Widget build(BuildContext context) {
    return
    new Center (
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Text("Get your food!", style: MyHeadline,),
            new Row (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                new Checkbox(value: _getList, onChanged: setGetList),
                _getList ?
                new FlatButton(
                    onPressed: search, child: new Text("Search"))
                    :
                new Text("test") //TODO: replace with search bar
              ],
            ),

              //TODO: implement the food being displayed (create food view?)

          ],
        )
    );
  }
}

class FoodLineDisplay extends StatelessWidget {
  rest.Food food;

  FoodLineDisplay(this.food);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Row(
      children: <Widget>[
        new Text(food.id.toString()),
        new SizedBox(width: 20),
        new Text(food.name),
        new SizedBox(width: 10),
        new Text(food.amount.toString())
      ],
    );
  }
}

enum _EWindow {
  home,
  getFood,
  updateFood,
  deleteFood
}

const TextStyle MyHeadline = TextStyle(
  color: Colors.amberAccent,
  fontSize: 36,
  decoration: TextDecoration.none,
  fontWeight: FontWeight.bold
);