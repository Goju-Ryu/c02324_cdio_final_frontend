import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:frontend_flutter/rest.dart' as rest;
import 'package:frontend_flutter/util/TextStyles.dart';
import 'package:frontend_flutter/util/sharedStates.dart';

class GetPage extends StatefulWidget {
  @override
  _GetPageState createState() => new _GetPageState();
}

class _GetPageState extends State<GetPage> {
  bool _getList = true;
  final TextEditingController textController = TextEditingController();

  void setGetList(bool b) {
    setState(() {
      _getList = b;
    });
  }

  void listSearch() async {
    print("ListSearch() - started");
    final foodListState = Provider.of<GetList>(context);
    final appState = Provider.of<AppState>(context);

    foodListState.setIsLoading(true);

    rest.getList(appState.getUser()).then((list) {
      foodListState.setIsLoading(false);
      foodListState.setGetList(list);
    });
  }

  void idSearch(int id) {
    print("idSearch()");
    final foodListState = Provider.of<GetList>(context);
    final appState = Provider.of<AppState>(context);

    foodListState.setIsLoading(true);

    rest.get(appState.getUser(), int.parse(textController.text)).then((food) {
      foodListState.setIsLoading(false);
      List<rest.Food> list = List<rest.Food>();
      list.add(food);
      foodListState.setGetList(list);
    });
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(width: 80,
                      child: new Text("Check to search for all food: ")),
                  new Checkbox(value: _getList, onChanged: setGetList),
                  new Flexible( //This is needed for the row to determine the size of textField. Without it an Error occurs and it isn't displayed.
                      flex: 1,
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter id'
                        ),
                        keyboardType: TextInputType.number,
                        controller: textController,
                      )
                  ),
                  new RaisedButton(
                    onPressed: () {
                      if (_getList) {
                        listSearch();
                      } else {
                        idSearch(int.parse(textController.text));
                      }
                    }, //onPressed
                    child: new Text("Search"),
                    shape: new RoundedRectangleBorder(),
                    color: Colors.blue,
                  ),
                ],
              ),
              new Expanded(
                  child: new FoodList()
              ),
              //TODO: implement the food being displayed (create food view?)

            ],
          )
      );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

}

class FoodList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final foodList = Provider.of<GetList>(context);
    if (foodList.getIsLoading()) {
      return new CircularProgressIndicator();
    } else {
      return new ListView(
        children: foodList.getGetList(),
      );
    }
  }

}

class GetList with ChangeNotifier {
  List<FoodLineDisplay> _list;
  bool _isLoading;

  GetList(this._list) {
    this._isLoading = false;
  }

  List<FoodLineDisplay> getGetList() {
    return _list;
  }

  void setGetList(List<rest.Food> list) {
    List<FoodLineDisplay> foodLines = new List<FoodLineDisplay>();
    list.forEach((f) {
      foodLines.add(FoodLineDisplay(f));
    });
    _list = foodLines;
    notifyListeners();
  }


  void setIsLoading(bool isLoading) {
    this._isLoading = isLoading;
  }

  bool getIsLoading() {
    return this._isLoading;
  }

}

class FoodLineDisplay extends StatelessWidget {
  final rest.Food food;

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
        new Text(food.date),
      ],
    );
  }
}