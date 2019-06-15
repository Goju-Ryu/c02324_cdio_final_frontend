import 'package:flutter/material.dart';
import 'package:frontend_flutter/rest.dart' as rest;

class UpdatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<TextEditingController> textConList = new List()
      ..add(TextEditingController())
      ..add(TextEditingController())
      ..add(TextEditingController());

    return Column(
      children: <Widget>[
        new Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: Column(
              children: <Widget>[
                Container(
                    child: TextFormField(
                      controller: textConList[0],
                      decoration:
                      InputDecoration(labelText: "ID", labelStyle: myText),
                      keyboardType: TextInputType.number,
                    )),
                Container(
                    child: TextFormField(
                      controller: textConList[1],
                      decoration:
                      InputDecoration(labelText: "Name", labelStyle: myText),
                      keyboardType: TextInputType.number,
                    )),
                Container(
                    child: TextFormField(
                      controller: textConList[2],
                      decoration:
                      InputDecoration(labelText: "Value", labelStyle: myText),
                      keyboardType: TextInputType.number,
                    )),
              ],
            )),
        new Flexible(
          flex: 1,
          child: new MaterialButton(
            child: Text("Add"),
            color: Colors.blue,
            onPressed: () {
              Map<String, String> ingredient = {
                "id": textConList[0].text,
                "name": textConList[1].text,
                "amount": textConList[2].text
              };
              rest.sendPost(ingredient: ingredient);
            },
          ),
        ),
      ],
    );
  }
}

const TextStyle myText = TextStyle(
  fontSize: 24,
);
