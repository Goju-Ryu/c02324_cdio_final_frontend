import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:FoodTracker/rest/rest.dart' as rest;
import 'package:FoodTracker/view/pages/mainMenu.dart';

class AppState with ChangeNotifier {
  String _user;
  Widget _page;
  int _notificationSetting; //TODO needs to be controlled in Settings

  AppState(this._user, {Widget page}){
    _notificationSetting = 2;
    if (page != null)
      this._page = page;
    else
      this._page = MainMenu();
  }

  void selectPage(Widget page) {
    _page = page;
    notifyListeners();
  }

  Widget getPage() {
    return _page;
  }

  void setUser(String userName) {
    bool b;
    rest.verifyUser(userName).then((response) {
      b = response;
    });
    if (b)
      this._user = userName;
    else
      throw new Exception("Couldn't find requested user");
  }

  String getUser() {
    return this._user;
  }

  int getNotificationSetting(){
    return _notificationSetting;
  }
}