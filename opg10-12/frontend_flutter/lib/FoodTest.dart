import 'package:flutter/material.dart';
import 'package:frontend_flutter/rest.dart' as rest;
import 'package:provider/provider.dart';

import 'package:frontend_flutter/views/HomeView.dart';
import 'package:frontend_flutter/views/updatePage.dart';
import 'package:frontend_flutter/views/getPage.dart';
import 'package:frontend_flutter/views/deletePage.dart';

import 'package:frontend_flutter/util/TextStyles.dart';
import 'package:frontend_flutter/util/sharedStates.dart';

void main() => runApp(new MyApp());

///Root of the app determining which view to be shown.
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      title: "Proof of concept ingredient app",
      home: ChangeNotifierProvider(builder: (_) => AppState("Pur"), child: new Home()),
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
        return new ChangeNotifierProvider( builder: (_) => GetList(new List<IngredientLineDisplay>(0)), child: new GetPage());
      }
      case (_EWindow.updateFood): {
        return new UpdatePage();
      }
      case (_EWindow.deleteFood): {
        return new DeletePage();
      }
      default: {
        throw new Exception("Home: _getWindow: unknown selection (" + _selection.toString() + " / " + _selection.index.toString() + ")");
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






enum _EWindow {
  home,
  getFood,
  updateFood,
  deleteFood
}
