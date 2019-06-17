import 'package:flutter/material.dart';
import 'stdColours.dart';

ButtonTheme btnTheme (context) {
  Color btnColor = Theme
      .of(context)
      .accentColor;
  final ButtonTheme btnTheme = ButtonTheme(
    buttonColor: secondaryColour,
    disabledColor: btnDisabledColour,
    highlightColor: btnHighlightColour,
    splashColor: btnSplashColour,
  );
  return btnTheme;
}