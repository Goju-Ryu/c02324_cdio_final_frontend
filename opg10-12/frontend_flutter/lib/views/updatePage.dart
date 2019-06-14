import 'package:flutter/material.dart';
import 'package:frontend_flutter/util/TextStyles.dart';
import 'package:frontend_flutter/util/sharedStates.dart';
import 'package:provider/provider.dart';

class UpdatePage extends StatefulWidget {
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  bool addNew = true;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        new Text(
          "Add/Update",
          style: MyHeadline,
        ),
        new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                //TODO insert all the fields here
                new Column(
                  children: <Widget>[new Text("id"), TextField(
                    //TODO insert textController here
                  )],
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
