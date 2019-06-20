import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester2_cdio_final/util/stdColours.dart';
import 'package:semester2_cdio_final/util/textStyles.dart';
import 'package:semester2_cdio_final/util/foodDTO.dart';
import 'package:semester2_cdio_final/util/enums.dart';
import 'package:semester2_cdio_final/util/sharedStates.dart';
import 'package:semester2_cdio_final/rest/rest.dart' as rest;
import 'package:semester2_cdio_final/view/pages/modifyItem.dart';
import 'package:semester2_cdio_final/view/pages/itemList.dart';


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
    _appState.selectPage(ItemList(getLocationEnum(_foodItem.location)));
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                    Text("Name:", style: labelStyle),
                    Text(this._foodItem.foodName, style: itemListStyle)
                  ],),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Category:", style: labelStyle),
                      Text(this._foodItem.category, style: itemListStyle)
                    ],),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Expiration date:", style: labelStyle),
                      Text(this._foodItem.expDate, style: itemListStyle)
                    ],),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Location:", style: labelStyle),
                      Text(this._foodItem.location, style: itemListStyle)
                    ],)
                ],
              ),
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
                textColor: btnTextColour,
                splashColor: btnSplashColour,
                color: secondaryColour,
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
              textColor: btnTextColour,
              splashColor: btnSplashColour,
              color: secondaryColour,
            ),
          )
        ]
    );
  }
}
