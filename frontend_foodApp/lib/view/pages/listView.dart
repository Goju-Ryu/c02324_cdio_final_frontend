import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MaterialApp(
      title: "ListView",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Fridge"),
        ),
        body: getListView(),
      )));
}

Widget getListView() {
  var listView = ListView(children: <Widget>[
    Card(
      child: ListTile(
        leading: Icon(Icons.accessible),
        title: Text('Rullestol'),
        onTap: () {},
      ),
    ),
    Card(
      child: ListTile(
        leading: Icon(Icons.ac_unit),
        title: Text('Shit det er koldt'),
        onTap: () {},
      ),
    ),
    Card(
      child: ListTile(
        leading: Icon(Icons.add_box),
        title: Text('Jeg dør'),
        onTap: () {},
      ),
    ),
  ]);

  return listView;
}

class ListButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListButton();
  }
}
