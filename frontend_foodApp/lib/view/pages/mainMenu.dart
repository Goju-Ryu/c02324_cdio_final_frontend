import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester2_cdio_final/util/textStyles.dart';
import 'package:semester2_cdio_final/util/buttonStyles.dart';
import 'package:semester2_cdio_final/util/stdColours.dart';
import 'package:semester2_cdio_final/util/sharedStates.dart';
import 'package:semester2_cdio_final/view/pages/listView.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //TODO: Delete when testing has finished
        SizedBox(
          height: 50,
          width: 50,
          child: DecoratedBox(
              decoration: BoxDecoration(
                  color: primaryColour)
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: MaterialButton(
            child: Text(
              "Freezer",
              style: CustomTextStyle.btnTxtStyle(),
            ),
            onPressed: () {appState.selectPage(ItemList());}/*TODO add method to link to Freezer page*/,
            color: secondaryColour,
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: MaterialButton(
            child: Text(
              "Refrigerator",
              style: CustomTextStyle.btnTxtStyle(),
            ),
            onPressed: () {}/*TODO: Add method to link to fridge page*/,
            color: secondaryColour,
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: MaterialButton(
            child: Text(
              "Pantry",
              style: CustomTextStyle.btnTxtStyle(),
            ),
            onPressed: () {}/*TODO: Add method to link to pantry page*/,
            color: secondaryColour,
          ),
        ),
        //TODO: Delete box when finished testing
        SizedBox(
          height: 50,
            width: 50,
          child: DecoratedBox(
              decoration: BoxDecoration(
                  color: primaryColour)
          ),
        )
      ],
    );
  }
}
