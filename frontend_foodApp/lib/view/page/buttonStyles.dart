import 'package:flutter/material.dart';


ButtonTheme btnTheme (context) {
  Color btnColor = Theme
      .of(context)
      .accentColor;
  final ButtonTheme btnTheme = ButtonTheme(
    buttonColor: Colors.blue,
    disabledColor: Colors.grey,
  );
  return btnTheme;
}