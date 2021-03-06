import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:frontend_flutter/rest.dart' as rest;
import 'package:frontend_flutter/util/TextStyles.dart';

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
    final ingredientListState = Provider.of<GetList>(context);

    ingredientListState.setIsLoading(true);

    rest.getList().then((list) {
      ingredientListState.setIsLoading(false);
      ingredientListState.setGetList(list);
    });
  }

  void idSearch(int id) {
    print("idSearch()");
    final ingredientListState = Provider.of<GetList>(context);

    ingredientListState.setIsLoading(true);

    rest.get(int.parse(textController.text)).then((ingredient) {
      ingredientListState.setIsLoading(false);
      List<rest.Ingredient> list = List<rest.Ingredient>();
      list.add(ingredient);
      ingredientListState.setGetList(list);
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
              new Text("Get your ingredients!", style: MyHeadline,),
              new Row (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(width: 80,
                      child: new Text("Check to search for all ingredients: ")),
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
                  child: new IngredientList()
              ),
              //TODO: implement the ingredients being displayed (create ingredient view?)

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

class IngredientList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ingredientList = Provider.of<GetList>(context);
    if (ingredientList.getIsLoading()) {
      return new CircularProgressIndicator();
    } else {
      return new DataTable(
        columns: [
          new DataColumn(label: Text("ID")),
          new DataColumn(label: Text("Name")),
          new DataColumn(label: Text("Amount"))
        ],
        rows:ingredientList.getGetList(),
      );
    }
  }
}

class GetList with ChangeNotifier {
  List<DataRow> _list;
  bool _isLoading;

  GetList(this._list) {
    this._isLoading = false;
  }

  List<DataRow> getGetList() {
    return _list;
  }

  void setGetList(List<rest.Ingredient> list) {
    List<DataRow> ingredientRow = new List<DataRow>();
    list.forEach((f) {
      ingredientRow.add(DataRow(cells: [
        new DataCell(Text(f.id.toString())),
        new DataCell(Text(f.name)),
        new DataCell(Text(f.amount.toString()))
      ])
      );
    });
    _list = ingredientRow;
    notifyListeners();
  }


  void setIsLoading(bool isLoading) {
    this._isLoading = isLoading;
  }

  bool getIsLoading() {
    return this._isLoading;
  }

}

//class DataRow extends StatelessWidget {
//  final rest.Ingredient ingredient;
//
//  DataRow(this.ingredient);
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return new Row(
//      children: <Widget>[
//        new Text(ingredient.id.toString()),
//        new SizedBox(width: 20),
//        new Text(ingredient.name),
//        new SizedBox(width: 10),
//        new Text(ingredient.amount.toString()),
//      ],
//    );
//  }
//}
