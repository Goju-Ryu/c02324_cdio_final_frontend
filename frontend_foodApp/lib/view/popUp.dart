import 'package:flutter/material.dart';
import 'package:semester2_cdio_final/util/foodDTO.dart';


class PopNotification {
  final List<FoodDTO> _itemList;

  PopNotification(this._itemList);

  information(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          print("Builder! ");
          return AlertDialog(
              title: Text("The following items are about to expire in less than 3 days:"),
              content: Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width - 20,
                child: Column(
                  children: [
                    Flexible (
                      flex: 1,

                      child: ListView(
                        shrinkWrap: true,
                        children: getCards(_itemList),

                      ),
                    ),
                    FlatButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("OK"),
                    )
                  ],
                ),
              ));
        });
  }

  List<Widget> getCards(List<FoodDTO> list) {
    return list
        .map((food) => Card(
      child: Text(food.foodName),
    ))
        .toList();
  }
}
