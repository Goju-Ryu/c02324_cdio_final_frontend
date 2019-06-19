import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester2_cdio_final/util/textStyles.dart';
import 'package:semester2_cdio_final/util/buttonStyles.dart';
import 'package:semester2_cdio_final/util/stdColours.dart';
import 'package:semester2_cdio_final/util/enums.dart';
import 'package:semester2_cdio_final/util/sharedStates.dart';
import 'package:semester2_cdio_final/view/pages/listView.dart';

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
              style: CustomTextStyle.btnTxtStyle(),
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
              style: CustomTextStyle.btnTxtStyle(),
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
              style: CustomTextStyle.btnTxtStyle(),
            ),
            onPressed: () {appState.selectPage(ItemList(ELocation.Pantry));},
            color: secondaryColour,
          ),
        ),
      ],
    );
  }
}
