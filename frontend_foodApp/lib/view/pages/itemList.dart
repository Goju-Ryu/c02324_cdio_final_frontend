import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:FoodTracker/util/foodDTO.dart';
import 'package:FoodTracker/util/enums.dart';
import 'package:FoodTracker/rest/rest.dart' as rest;
import 'package:FoodTracker/util/sharedStates.dart';
import 'package:FoodTracker/view/pages/itemInfo.dart';

//Put this widget in main body to make the list of foods
class ItemList extends StatelessWidget {
  final ELocation _location;

  ItemList(this._location);

  List<Widget> createButtonList(List<FoodDTO> itemList) {
    if (itemList == null || itemList.length < 1)
      return <Widget>[
        Card(
          child: ListTile(
            title: Text("Empty"),
          ),
        )
      ];

    List<Widget> list = new List<Widget>();

    for (int i = 0; i < itemList.length; i++) {
      list.add(new ListButton(itemList[i]));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return
      FutureBuilder(
        future: rest.getFoodList(appState.getUser(), this._location.index),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Error: " + snapshot.error);
            return
            Card(
              child: ListTile(
                title: Text("Error: " + snapshot.error.toString()),
              ),
            );
          }
          if (snapshot.hasData) {

            return
              ListView(children: createButtonList(snapshot.data));
          }
            return Center(child: CircularProgressIndicator());

        },

      );


  }
}

class ListButton extends StatelessWidget {
  final FoodDTO _food;

  ListButton(this._food);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Card(
      child: ListTile(
        title: Text(this._food.foodName),
        onTap: () {
          appState.selectPage(Item(this._food));
        },
      ),
    );
  }
}
