import 'package:flutter/material.dart';
import 'package:frontend_flutter/rest.dart' as rest;
import 'package:frontend_flutter/util/TextStyles.dart';
import 'package:frontend_flutter/util/sharedStates.dart';
import 'package:provider/provider.dart';

class DeletePage extends StatelessWidget {
  final TextEditingController textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    // TODO: implement build
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Text("Delete Food", style: MyHeadline),

            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new SizedBox( //This is needed for the row to determine the size of textField. Without it an Error occurs and it isn't displayed.
                  width: 150,
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Enter id'),
                    keyboardType: TextInputType.number,
                    controller: textController,
                  ),
                ),

                new RaisedButton(
                  onPressed: () {
                    rest.deleteFood(
                        int.parse(textController.text), appState.getUser());
                  }, //onPressed
                  child: new Text("Delete"),
                  shape: new RoundedRectangleBorder(),
                  color: Colors.blue,
                ),
              ],
            ),

        ],
      ),
    );
  }
}
