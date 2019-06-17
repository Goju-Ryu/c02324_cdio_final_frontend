import 'package:flutter/material.dart';


class Item extends StatelessWidget {
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
            child:
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Smør'), //TODO add food_name getter
              Text('Mælkeprodukt'), //TODO add Category getter
              Text("2019-06-18"), //TODO add Exp_date getter
              Text('Skabet'), //TODO add location getter
            ],
          ),
          ),

          Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: MaterialButton( //BUTTON style
                child: Text('Update', style: TextStyle(fontSize: 36),),
                onPressed: update,
                textColor: Colors.red,
                splashColor: Colors.redAccent,
              color: Theme.of(context).accentColor,
              )),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: MaterialButton( // BUTTON STYLE
              child: Text('Delete', style: TextStyle(fontSize: 36),),
              onPressed: delete,
              textColor: Colors.red,
              splashColor: Colors.redAccent,
              color: Theme.of(context).accentColor,

          
            ),
          )
        ]);
  }
}
