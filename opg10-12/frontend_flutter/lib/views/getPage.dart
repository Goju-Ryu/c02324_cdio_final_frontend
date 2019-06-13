import 'package:flutter/material.dart';
import 'package:frontend_flutter/rest.dart' as rest;
import 'package:frontend_flutter/styles/TextStyles.dart';
import 'package:provider/provider.dart';

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

    foodListState.setGetList(rest.getList("Pur"));
  }

  void idSearch(int id) {
    print("idSearch()");
    final foodListState = Provider.of<GetList>(context);
    List<FoodLineDisplay> newList = List<FoodLineDisplay>();

    final future = rest.get("Pur", id);
    print(future.toString());
  }

  @override
  Widget build(BuildContext context) {
    final foodListState = Provider.of<GetList>(context);
    return new Center(
        child: new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Text(
          "Get your food!",
          style: MyHeadline,
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 80, child: new Text("Check to search for all food: ")),
            new Checkbox(value: _getList, onChanged: setGetList),
            new Flexible(
                //This is needed for the row to determine the size of textField. Without it an Error occurs and it isn't displayed.
                flex: 1,
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Enter id'),
                  keyboardType: TextInputType.number,
                  controller: textController,
                )),
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
        new Expanded(child: new FoodList()),
        //TODO: implement the food being displayed (create food view?)
      ],
    ));
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
    return new ListView(
      children: foodList.getFoodLineList(),
    );
  }
}

class GetList with ChangeNotifier {
  Future<List<rest.Food>> _list;

  GetList(this._list);

  Future<List<rest.Food>> getGetList() {
    return _list;
  }

  void setGetList(Future<List<rest.Food>> list) {
    _list = list;
    notifyListeners();
  }

  getFoodLineList() {
    return FutureBuilder<List<rest.Food>>(
      future: _list,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error.toString());
          return Text(
            snapshot.error.toString(),
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                decoration: TextDecoration.none,
                color: Colors.red),
          );
        } else if (snapshot.hasData) {
          print("Success");
          List<FoodLineDisplay> list;
          for (int i = 0; i < snapshot.data.length; i++) {
            list.add(new FoodLineDisplay(snapshot.data[i]));
          }
          return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return list[index];
              }); // a code fragment gotten from https://stackoverflow.com/questions/55011075/return-a-list-from-a-future-in-flutter
        }

        //by default, show a loading spinner
        print("Loading");
        //return CircularProgressIndicator();
      },
    );
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
