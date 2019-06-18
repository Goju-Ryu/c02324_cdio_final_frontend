import 'package:flutter/material.dart';

import 'package:semester2_cdio_final/rest/foodDTO.dart';
import 'package:semester2_cdio_final/rest/rest.dart' as rest;
import 'package:semester2_cdio_final/view/pages/mainMenu.dart';

class AppState with ChangeNotifier {
  String _user;
  Widget _page;

  AppState(this._user, {Widget page}){
    if (page != null)
      this._page = page;
    else
      this._page = MainMenu();
  }

  void selectPage(Widget page) {
    _page = page;
    notifyListeners();
  }

  Widget getPage(){
    return _page;
  }

  void setUser(String userName) {
    bool b;
    rest.verifyUser(userName).then((response){b = response;});
    if (b)
      this._user = userName;
    else
      throw new Exception("Couldn't find requested user");
  }

  String getUser() {
    return this._user;
  }
}


class FoodList with ChangeNotifier {
  bool _useDummyList;
  List<FoodDTO> _list;

  FoodList.dummyList () {
    this._useDummyList = true;
    this._list = this._getDummyData();
  }

  FoodList.restList(String user) {
    this._useDummyList = false;
    rest.getFoodList(user, "Freezer").then((futureList) {this._list = futureList;});

  }

  void setList(List<FoodDTO> list) {
    this._list = list;
  }

  void addToList(FoodDTO item) {
    this._list.add(item);
  }

  void removeFromList(FoodDTO item) {
    this._list.remove(item);
  }

  List<FoodDTO> getList() {
    return this._list;
  }
  
  List<FoodDTO> _getDummyData() {
    List<FoodDTO> list = List<FoodDTO>();
    list.add(FoodDTO(foodId: 1, foodName: "Icecream", expDate: "2020-02-15", category: "Other", location: "Freezer"));
    list.add(FoodDTO(foodId: 2, foodName: "Steak", expDate: "2019-07-03", category: "Beef", location: "Freezer"));
    return list;
  }

}

enum ELocation { freezer, fridge, pantry }