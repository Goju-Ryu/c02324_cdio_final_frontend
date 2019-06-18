import 'package:flutter/material.dart';
import 'package:semester2_cdio_final/rest/foodDTO.dart';
import 'package:semester2_cdio_final/view/pages/listView.dart';

class Notification{
  information(BuildContext context, List<FoodDTO> itemList){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
      return AlertDialog(
        title: Text("The following items are about to expire"),
        content: ListBody(
          children: <Widget>[


            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            )
          ],
        )

      );
    });
  }
}

