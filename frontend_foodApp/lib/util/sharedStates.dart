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
    this._user = userName; //TODO check if valid over rest
  }

  String getUser() {
    return this._user;
  }
}


class FoodList with ChangeNotifier {
  List<FoodDTO> _list;

  FoodList (bool useDummyList) {
    List<FoodDTO> list;
    
    if (useDummyList)
      list = this._getDummyData();
    else 
      rest.getList().then((flist) {list = flist;});
      
    this._list = list;
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