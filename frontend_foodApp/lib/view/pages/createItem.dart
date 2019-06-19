import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:semester2_cdio_final/rest/rest.dart' as rest;
import 'package:semester2_cdio_final/util/enums.dart';
import 'package:semester2_cdio_final/util/foodDTO.dart';

class CreateItem extends StatefulWidget{
  @override
  _CreateItemState createState() => _CreateItemState();
}

class _CreateItemState extends State<CreateItem> {
  TextEditingController _foodName = new TextEditingController();
  ELocation _location;
  ECategory _category;
  TextEditingController _expDate = new TextEditingController();


  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Flexible(
          fit: FlexFit.tight,
          flex: 5,
          child:
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField( decoration: InputDecoration(
                    labelText: "Food name"),
                    controller: _foodName,
                ),

                 DropdownButton(
                    value: _location,
                    items: generateSelectionList(ELocation.values),
                    onChanged: (value) {setState((){_location = value;});},
                  ),

                DropdownButton(
                  value: _category,
                  items: generateSelectionList(ECategory.values),
                  onChanged: (value) {setState((){_category = value;});},
                ),

                TextFormField(
                  decoration: InputDecoration( // TODO replace with scrolling date
                  labelText: "Expiration"),
                  controller: _expDate,
                ),
                  SizedBox(height: 30),
                RaisedButton(
                  onPressed: () {
                    rest.addFood({
                      "foodName": _foodName.text,
                      "location": getLocationName(_location),
                      "category": getCategoryName(_category),
                      "expDate": _expDate.text,
                    });
                  }, //TODO implement method
                  child: const Text(
                      'Send',
                      style: TextStyle(fontSize: 20)
                  ),
                ),
              ]
          ),
        ),
      ],
    );
  }
}

List<DropdownMenuItem> generateSelectionList(List list) {
  List<DropdownMenuItem<dynamic>> menuItems = new List<DropdownMenuItem<dynamic>>();
  for (int i = 0; i < list.length; i++) {
    menuItems.add(new DropdownMenuItem(
        value: list[i],
        child: Text(list[i].toString().split(".")[1]),
    ));
  }
  return menuItems;
}