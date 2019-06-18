import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:semester2_cdio_final/rest/foodDTO.dart';
import 'package:semester2_cdio_final/util/sharedStates.dart';
import 'package:semester2_cdio_final/view/pages/itemInfo.dart';

//Put this widget in main body to make the list of foods
class ItemList extends StatelessWidget {
  List<Widget> createButtonList(List<FoodDTO> itemList) {
    if (itemList == null)
      return <Widget>[
        Card(
          child: ListTile(
            title: Text("Empty"),
          ),
        )
      ];

    List<Widget> list = new List<Widget>();

    for (int i = 0; i < itemList.length; i++) {
      list.add(new ListButton(itemList[i]));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final foodList = Provider.of<FoodList>(context);
    return ListView(children: createButtonList(foodList.getList()));
  }
}

class ListButton extends StatelessWidget {
  final FoodDTO _food;

  ListButton(this._food);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Card(
      child: ListTile(
        title: Text(this._food.foodName),
        onTap: () {
          appState.selectPage(Item(this._food));
        },
      ),
    );
  }
}
