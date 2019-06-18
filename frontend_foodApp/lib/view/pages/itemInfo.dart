import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester2_cdio_final/util/foodDTO.dart';
import 'package:semester2_cdio_final/util/enums.dart';
import 'package:semester2_cdio_final/util/sharedStates.dart';
import 'package:semester2_cdio_final/rest/rest.dart' as rest;
import 'package:semester2_cdio_final/view/pages/modifyItem.dart';


class Item extends StatelessWidget {
  final FoodDTO _foodItem;
  AppState _appState;
  //FoodList _foodList;

  Item(this._foodItem);

  void update() {
    _appState.selectPage(ModifyItem(_foodItem));
  }

  void delete() {
    //_foodList.removeFromList(_foodItem);
    rest.deleteFood(_appState.getUser(), this._foodItem.foodId);
  }

  @override
  Widget build(BuildContext context) {
    this._appState = Provider.of<AppState>(context);
    //this._foodList = Provider.of<FoodList>(context);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(this._foodItem.foodName),
                Text(this._foodItem.category),
                Text(this._foodItem.expDate),
                Text(this._foodItem.location),
              ],
            ),
          ),
          Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: MaterialButton(
                //BUTTON style
                child: Text(
                  'Update',
                  style: TextStyle(fontSize: 36),
                ),
                onPressed: update,
                textColor: Colors.red,
                splashColor: Colors.redAccent,
                color: Theme.of(context).accentColor,
              )),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: MaterialButton(
              // BUTTON STYLE
              child: Text(
                'Delete',
                style: TextStyle(fontSize: 36),
              ),
              onPressed: delete,
              textColor: Colors.red,
              splashColor: Colors.redAccent,
              color: Theme.of(context).accentColor,
            ),
          )
        ]
    );
  }
}
