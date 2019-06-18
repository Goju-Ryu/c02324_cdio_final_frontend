import 'package:flutter/material.dart';
import 'package:semester2_cdio_final/rest/foodDTO.dart';
import 'package:semester2_cdio_final/rest/rest.dart' as rest;
import 'package:semester2_cdio_final/view/pages/mainMenu.dart';

class AppState with ChangeNotifier {
  String _user;
  Widget _page;

  AppState(this._user, {Widget page}) {
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
}

class FoodList with ChangeNotifier {
  bool _useDummyList;
  List<FoodDTO> _freezerList;
  List<FoodDTO> _fridgeList;
  List<FoodDTO> _pantryList;

  FoodList.dummyList() {
    this._useDummyList = true;
    this._freezerList = this._getDummyData(ELocation.freezer);
    this._freezerList = this._getDummyData(ELocation.fridge);
    this._freezerList = this._getDummyData(ELocation.pantry);
  }

  FoodList.restList(String user) {
    this._useDummyList = false;
    rest.getFoodList(user, "Freezer").then((futureList) {
      this._freezerList = futureList;
    });
    rest.getFoodList(user, "Fridge").then((futureList) {
      this._fridgeList = futureList;
    });
    rest.getFoodList(user, "Pantry").then((futureList) {
      this._pantryList = futureList;
    });
  }

  void setList(List<FoodDTO> list, ELocation location) {
    switch (location) {
      case ELocation.freezer:
        this._freezerList = list;
        break;
      case ELocation.fridge:
        this._fridgeList = list;
        break;
      case ELocation.pantry:
        this._pantryList = list;
        break;
    }
  }

  void addToList(FoodDTO item, ELocation location) {
    switch (location) {
      case ELocation.freezer:
        this._freezerList.add(item);
        break;
      case ELocation.fridge:
        this._fridgeList.add(item);
        break;
      case ELocation.pantry:
        this._pantryList.add(item);
        break;
    }
  }

  void removeFromList(FoodDTO item, ELocation location) {
    switch (location) {
      case ELocation.freezer:
        this._freezerList.remove(item);
        break;
      case ELocation.fridge:
        this._fridgeList.remove(item);
        break;
      case ELocation.pantry:
        this._pantryList.remove(item);
        break;
    }
  }

  List<FoodDTO> getList(ELocation location) {
    switch (location) {
      case ELocation.freezer:
        return this._freezerList;
      case ELocation.fridge:
        return this._fridgeList;
      case ELocation.pantry:
        return this._pantryList;
      default:
        throw new Exception("No such List found");
    }
  }

  List<FoodDTO> _getDummyData(ELocation location) {
    List<FoodDTO> list = List<FoodDTO>();
    list.add(FoodDTO(
        foodId: 1,
        foodName: "Icecream",
        expDate: "2020-02-15",
        category: "Other",
        location: location.toString()));
    list.add(FoodDTO(
        foodId: 2,
        foodName: "Steak",
        expDate: "2019-07-03",
        category: "Beef",
        location: location.toString()));
    return list;
  }
}

enum ELocation { freezer, fridge, pantry }
