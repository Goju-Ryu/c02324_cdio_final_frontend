import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:FoodTracker/rest/rest.dart' as rest;
import 'package:FoodTracker/util/enums.dart';
import 'package:FoodTracker/util/sharedStates.dart';
import 'package:FoodTracker/util/stdColours.dart';
import 'package:FoodTracker/util/foodDTO.dart';
import 'package:FoodTracker/view/pages/itemList.dart';

class ModifyItem extends StatefulWidget {
  final FoodDTO _food;

  ModifyItem(this._food);

  @override
  _ModifyItemState createState() => _ModifyItemState(_food);
}

class _ModifyItemState extends State<ModifyItem> {
  final FoodDTO _food;

  TextEditingController _foodName = new TextEditingController();
  ELocation _location;
  ECategory _category;
  DateTime _expDate;

  _ModifyItemState(this._food) {
    _foodName.text = _food.foodName;
    _location = getLocationEnum(_food.location);
    _category = getCategoryEnum(_food.category);
    _expDate = DateTime.parse(_food.expDate);
  }

  _pickDate() async {
    _expDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now().add(Duration(days: 1)),
        firstDate: DateTime.now().add(Duration(days: -1)),
        lastDate: DateTime(
            DateTime
                .now()
                .year + 30) // last date is current year + 30 years
    );

    setState(() {});
  }

  Widget build(BuildContext context) {
    final _appState = Provider.of<AppState>(context);
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: "Food name"),
                    controller: _foodName,
                  ),
                  DropdownButton(
                    value: _location,
                    items: generateSelectionList(ELocation.values),
                    onChanged: (value) {
                      setState(() {
                        _location = value;
                      });
                    },
                    hint: Text("Choose a location"),
                    isExpanded: true,
                  ),
                  DropdownButton(
                    value: _category,
                    items: generateSelectionList(ECategory.values),
                    onChanged: (value) {
                      setState(() {
                        _category = value;
                      });
                    },
                    hint: Text("Choose a cagory"),
                    isExpanded: true,
                  ),
                  (_location == ELocation.Freezer &&
                      _category != ECategory.Other)
                      ? Container()
                      : FlatButton(
                    color: btnHighlightColour,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.calendar_today),
                          (_expDate == null)
                              ? Text("Pick expiration date")
                              : Text(
                            _expDate.toString(),
                          )
                        ]),
                    onPressed: _pickDate,
                  ),
                  SizedBox(height: 30),
                  RaisedButton(
                    onPressed: () {
                      if (_foodName.text == null || _foodName.text == "") {
                        _createDialog(context, "Error",
                            "You have to enter a name of your food");
                        return;
                      }
                      if (_location == null) {
                        _createDialog(context, "Error",
                            "You have to enter a location for your food");
                        return;
                      }
                      if (_category == null) {
                        _createDialog(context, "Error",
                            "You have to enter a category for your food");
                        return;
                      }
                      if (_expDate == null &&
                          (_location != ELocation.Freezer ||
                              _category == ECategory.Other)) {
                        _createDialog(context, "Error",
                            "You have to enter a date for your food");
                        return;
                      }

                      rest.updateFood(_appState.getUser(), _food.foodId, {
                        "userName": _appState.getUser(),
                        "foodName": _foodName.text,
                        "location": getLocationName(_location),
                        "category": getCategoryName(_category),
                        "expDate": _expDate.millisecondsSinceEpoch.toString(),
                      }).then((onValue) {
                        _createSnackBar(context, onValue);
                      });

                      _appState.selectPage(ItemList(getLocationEnum(_food.location)));
                    },
                    child: const Text('Send', style: TextStyle(fontSize: 20)),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}

List<DropdownMenuItem> generateSelectionList(List list) {
  List<DropdownMenuItem<dynamic>> menuItems =
  new List<DropdownMenuItem<dynamic>>();
  for (int i = 0; i < list.length; i++) {
    menuItems.add(new DropdownMenuItem(
      value: list[i],
      child: Text(list[i].toString().split(".")[1]),
    ));
  }
  return menuItems;
}

_createSnackBar(BuildContext context, String content) {
  Scaffold.of(context).showSnackBar(new SnackBar(
    content: Text(content),
  ));
}

_createDialog(BuildContext context, String title, String content) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Confirm"),
            )
          ],
        );
      });
}
