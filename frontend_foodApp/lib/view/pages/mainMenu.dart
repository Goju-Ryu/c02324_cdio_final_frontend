import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:FoodTracker/util/textStyles.dart';
import 'package:FoodTracker/util/buttonStyles.dart';
import 'package:FoodTracker/util/stdColours.dart';
import 'package:FoodTracker/util/enums.dart';
import 'package:FoodTracker/util/sharedStates.dart';
import 'package:FoodTracker/view/pages/itemList.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        //Freezer
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: MaterialButton(
            child: Text(
              "Freezer",
              style: btnTxtStyle,
            ),
            onPressed: () {appState.selectPage(ItemList(ELocation.Freezer));},
            color: secondaryColour,
          ),
        ),

        //Fridge
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: MaterialButton(
            child: Text(
              "Refrigerator",
              style: btnTxtStyle,
            ),
            onPressed: () {appState.selectPage(ItemList(ELocation.Fridge));},
            color: secondaryColour,
          ),
        ),

        //Pantry
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: MaterialButton(
            child: Text(
              "Pantry",
              style: btnTxtStyle,
            ),
            onPressed: () {appState.selectPage(ItemList(ELocation.Pantry));},
            color: secondaryColour,
          ),
        ),
      ],
    );
  }
}
