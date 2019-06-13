import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  String _user;

  AppState(this._user);

  getUser() {return this._user;}

  setUser(user) {
    this._user = user;
  }
}