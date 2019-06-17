import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  String _user = "Pur";
  EPages _selection = EPages.mainMenu;

  AppState(this._user, {EPages selection}){
    if (selection != null)
      this._selection = selection;
    else
      this._selection = EPages.mainMenu;
  }

  void selectPage(EPages selection) {
    _selection = selection;
    notifyListeners();
  }

  EPages getSelection(){
    return _selection;
  }

  void setUser(String userName) {
    this._user = userName; //TODO check if valid over rest
  }

  String getUser() {
    return this._user;
  }


}

enum EPages { mainMenu, itemList, createItem, itemView, updateItem }