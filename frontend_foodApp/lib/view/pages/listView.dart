import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:semester2_cdio_final/rest/foodDTO.dart';


void main(){
  runApp(MaterialApp(
    title:"ListView",
    home: Scaffold(
      appBar: AppBar(title: Text("Fridge"),),
      body: getListView(),
    )
  ));
}



//Put this widget in main body to make the list of foods
Widget getListView() {
  var listView = ListView(
    children: <Widget>[


      //Use ListButton class instead
      Card(
        child: ListTile(
          leading: Icon(Icons.accessible),
          title: Text('Rullestol'),
          onTap: (){},
        ),
      ),


      Card(
        child: ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text('Shit det er koldt'),
            onTap: (){},
        ),
      ),

      Card(
        child: ListTile(
            leading: Icon(Icons.add_box),
            title: Text('Jeg dør'),
            onTap: (){},
        ),
      ),
    ]
  );

  return listView;
}

class ListButton extends StatelessWidget {
  final FoodDTO _food;
  
  ListButton(this._food);
  
  @override
  Widget build(BuildContext context) {

    return Card(
      child: ListTile(
        title: Text(this._food.foodName),
        onTap: (){},
      ),
    );


  }

}

