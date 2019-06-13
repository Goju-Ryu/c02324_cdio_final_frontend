import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:frontend_flutter/rest.dart' as rest;
import 'package:frontend_flutter/styles/TextStyles.dart';

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
    List<FoodLineDisplay> newList = List<FoodLineDisplay>();

    print("Building future");
    new FutureBuilder<List<rest.Food>> ( //TODO: måske skal denne returnere en widget?
      future: rest.getList("Pur"),
      builder: (context, snapshot) {
        print("Builder - start");
        if (snapshot.hasError) {
          print("Error!");
          newList.add(
              FoodLineDisplay(rest.Food(name: snapshot.error.toString())));
          foodListState.setIsLoading(false);
          foodListState.setGetList(newList);
        } else if (snapshot.hasData) {
          print("Success!");
          for (rest.Food food in snapshot.data) {
            newList.add(new FoodLineDisplay(food));
          }
          foodListState.setIsLoading(false);
          foodListState.setGetList(newList);
        }
        print("Builder - end");
        foodListState.setIsLoading(true);
        print("listSearch() - end");
        return null;
      },
    );
  }

  void idSearch (int id) {
    print("idSearch()");
    final foodListState = Provider.of<GetList>(context);
    List<FoodLineDisplay> newList = List<FoodLineDisplay>();

    final future = rest.get("Pur", id);
    print(future.toString());
    new FutureBuilder<rest.Food> (
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          newList.add(
              FoodLineDisplay(rest.Food(name: snapshot.error.toString())));
          foodListState.setIsLoading(false);
          foodListState.setGetList(newList);
        } else if (snapshot.hasData) {
          newList.add(new FoodLineDisplay(snapshot.data));
          foodListState.setIsLoading(false);
          foodListState.setGetList(newList);
        }

        foodListState.setIsLoading(true);
        print("idSearch() - end");
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    final foodListState = Provider.of<GetList>(context);
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
                  Container(width: 80, child: new Text("Check to search for all food: ")),
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
    if (foodList.getIsLoading()){
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

  void setGetList(List<FoodLineDisplay> list) {
    _list = list;
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
      ],
    );
  }
}