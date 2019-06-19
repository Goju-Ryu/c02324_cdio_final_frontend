import 'package:flutter/material.dart';
import 'package:semester2_cdio_final/rest/rest.dart' as rest;
import 'package:semester2_cdio_final/util/enums.dart';
import 'package:semester2_cdio_final/util/stdColours.dart';
import 'package:semester2_cdio_final/util/textStyles.dart';

class CreateItem extends StatefulWidget {
  @override
  _CreateItemState createState() => _CreateItemState();
}

class _CreateItemState extends State<CreateItem> {
  TextEditingController _foodName = new TextEditingController();
  ELocation _location;
  ECategory _category;
  DateTime _expDate;

  //TextEditingController _expDate = new TextEditingController();

  _pickDate() async {
    _expDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now().add(Duration(days: 1)),
        firstDate: DateTime.now().add(Duration(days: -1)),
        lastDate: DateTime(DateTime.now().year + 30) // last date is current year + 30 years
    );
  }

  Widget build(BuildContext context) {
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
                  (_location == ELocation.Freezer && _category != ECategory.Other)
                      ? Container()
                      : FlatButton(
                    color: btnHighlightColour,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      Icon(Icons.calendar_today),
                      (_expDate == null)
                          ? Text("Pick expiration date")
                          : Text(_expDate.toString(), style: btnTxtStyle,)
                    ]),
                    onPressed: _pickDate,
                  ),
//                    TextFormField(
//                      decoration: InputDecoration(
//                          // TODO replace with scrolling date
//                          labelText: "Expiration"),
//                      controller: _expDate,
//                    ),
                  SizedBox(height: 30),
                  RaisedButton(
                    onPressed: () {
                      //if (_foodName.text = null) {}
                        rest.addFood({
                          "foodName": _foodName.text,
                          "location": getLocationName(_location),
                          "category": getCategoryName(_category),
                          "expDate": _expDate.millisecondsSinceEpoch.toString(),
                        });
                    }, //TODO implement method
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
