import 'package:flutter/material.dart';
import 'package:semester2_cdio_final/rest/foodDTO.dart';
import 'package:semester2_cdio_final/util/sharedStates.dart';

class Item extends StatelessWidget {
  final FoodDTO _foodItem;

  Item(this._foodItem);

  void update() {
    //Todo: implement update
  }

  void delete() {
    //Todo: implement delete
  }

  @override
  Widget build(BuildContext context) {
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
