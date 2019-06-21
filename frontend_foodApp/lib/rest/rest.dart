import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:FoodTracker/util/foodDTO.dart';

final String _root = 'http://10.16.167.245:8080/rest/food/user';
int _isWritingToDB = 0;


///
///Sends HTTP.GET request to get a food item
///PARAMETERS: Username, FoodID
///
Future<FoodDTO> getFood(String userName, int foodId) async {
  String url = _root + "/" + userName + "/get/" + foodId.toString();
  Map<String, String> headers = {"Content-type": "application/json"};

  await _isReadReady(); //Waits to make sure the request has gone through

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) { // StatusCode 200 means success
    //if server returns success
    return FoodDTO.fromJson(json.decode(response.body));
  } else {
    //if response was not success, throw an exception and print error
    print('Error in fetchMessage');
    print("Error type: " + response.statusCode.toString());
    print(response.body);
    throw Exception('Failed to load Message');
  }
}

///
///Sends HTTP.GET request to get list of expired foods
///PARAMETERS: Username, amount of days until foods expire
///
Future<List<FoodDTO>> getExpiredFood(String userName, int days) async {
  String url = _root + "/" + userName + "/get/expire/" + days.toString();
  Map<String, String> headers = {"Content-type": "application/json"};

  await _isReadReady();

  final response = await http.get(url, headers: headers);
  print("på den anden side");
  if (response.statusCode == 200) {  // StatusCode 200 means success

    //if server returns success
    Iterable foods = json.decode(response.body);
    return foods
        .map((foodElement) => FoodDTO.fromJson(foodElement))
        .toList(); //Maps our foodElements and returns a list of JSON elements in a string
  } else {
    //if response was not success, throw an exception and print error
    print('Error in fetchMessage');
    print("Error type: " + response.statusCode.toString());
    print(response.body);
    throw Exception('Failed to load Message');
  }
}

///
///Sends HTTP.GET request to get list of foods from a specific location
///PARAMETERS: Username, Location
///
Future<List<FoodDTO>> getFoodList(String userName, int location) async {
  String url = _root + "/" + userName + "/get/storage/" + location.toString();
  Map<String, String> headers = {"Content-type": "application/json"};

  await _isReadReady();

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {  // StatusCode 200 means success

    //if server returns success
    Iterable foods = json.decode(response.body); //Henrik
    print("got response: " + response.body);
    return foods
        .map((foodElement) => FoodDTO.fromJson(foodElement))
        .toList(); //Henrik
  } else {
    //if response was not success, throw an exception and print error
    print('Error in fetchMessage');
    print("Error type: " + response.statusCode.toString());
    print(response.body);
    throw Exception('Failed to load Message');
  }
}

///
///Sends HTTP.POST request to add a food to the database
///PARAMETERS: FoodItem
///
Future<String> addFood([Map<String, String> food]) async {
  String url = _root;
  Map<String, String> header = {"Content-type": "application/json"};
  print("Adding food: " + food.toString());

  _isWritingToDB++; //While creating/updating/deleting food: This is used to make sure to postpone get requests.

  final response = await http.post(url,
      headers: header,
      body: jsonEncode(food),
      encoding: Encoding.getByName("json"));

  if (response.statusCode == 201) { // StatusCode 201 means success
    _isWritingToDB--;

    print("Food successfully created");
    return "Food successfully created";
  } else { //if response was not success, print an error
    print('Error in food creation');
    print("Error type: " + response.statusCode.toString());
    print(response.body);
    return 'Failed to create food';
  }
}

///
///Sends HTTP.DELETE request to delete a specific item
///PARAMETERS: Username, FoodID
///
Future<String> deleteFood(String userName, int foodId) async {
  String url = _root + "/" + userName + "/delete/" + foodId.toString();
  print(url);

  _isWritingToDB++;

  final response = await http.delete(url);

  _isWritingToDB--;

  if (response.statusCode == 200) {  // StatusCode 200 means success
    return "Food successfully deleted";

  } else { //if response was not success, throw an exception and print error
    print("Error in deletion");
    print("Error type: " + response.statusCode.toString());
    print(response.body);
    throw Exception("Something went wrong");
  }
}

///
///Sends HTTP.DELETE request to delete all items in a specific location
///PARAMETERS: Username, Location
///
Future<String> deleteAllFood(String userName, String location) async {
  String url = _root + "/" + userName + "/delete/all/" + location;
  print(url);

  _isWritingToDB++;

  final response = await http.delete(url);

  _isWritingToDB--;

  if (response.statusCode == 200) { // StatusCode 200 means success
    return "Food successfully deleted";

  } else { //if response was not success, throw an exception and print error
    print("Error in deletion");
    print("Error type: " + response.statusCode.toString());
    print(response.body);
    throw Exception("Something went wrong");
  }
}

///
///Sends HTTP.PUT request to update a specific food item
///PARAMETERS: Username, FoodId, FoodItem
///
Future<String> updateFood(
    String userName, int foodId, Map<String, String> food) async {
  String url = _root + "/" + userName + "/put/" + foodId.toString();
  Map<String, String> headers = {"Content-type": "application/json"};

  _isWritingToDB++;

  final response = await http.put(url,
      headers: headers,
      body: jsonEncode(food),
      encoding: Encoding.getByName("json"));

  _isWritingToDB--;

  if (response.statusCode == 200) {  // StatusCode 200 means success
    //400
    return "The food item has been updated";
  } else {  //if response was not success, throw an exception and print error
    print("Error when updating");
    print("Error type: " + response.statusCode.toString());
    print(response.body);
    throw Exception("Something went wrong");
  }
}

///
///Sends HTTP.POST request to add a new user
///PARAMETERS: UserName
///
Future<String> addUser(String userName) async {
  String url = _root + "/" + userName + "/add";
  print(url);

  Map<String, String> header = {"Content-type": "application/json"};

  final response = await http.post(url,
      headers: header,
      body: jsonEncode(userName),
      encoding: Encoding.getByName("json"));

  if (response.statusCode == 201) {  // StatusCode 201 means success
    return "User successfully created";
  } else {  //if response was not success, throw an exception and print error
    print('Error in user creation');
    print("Error type: " + response.statusCode.toString());
    print(response.body);
    throw Exception('Failed to create user');
  }
}


///
///Sends HTTP.DELETE request to delete a specific user
///PARAMETERS: Username
///
Future<String> deleteUser(String userName) async {
  String url = _root + "/" + userName + "/delete";
  print(url);
  final response = await http.delete(url);

  if (response.statusCode == 200) {  // StatusCode 200 means success
    return "User successfully deleted"; //Post.fromJson(json.decode(response.body));

  } else {  //if response was not success, throw an exception and print error
    print("Error in deletion");
    print("Error type: " + response.statusCode.toString());
    print(response.body);
    throw Exception("Something went wrong");
  }
}

///
///Sends HTTP.GET request to verify a username
///PARAMETERS: Username
///
Future<bool> verifyUser(String userName) async {
  String url = _root + "/" + userName + "/get/verify";
  print(url);

  final response = await http.get(url);

  if (response.statusCode == 200) {  // StatusCode 200 means success
    //if server returns okay
    return true;
  } else if (response.statusCode == 404) {
    //user doesn't exist
    return false;
  } else {  //if response was not success, throw an exception and print error
    //if response was not okay, throw an error
    print('User does not exist');
    print("Error type: " + response.statusCode.toString());
    print(response.body);
    throw Exception('User does not exist');
  }
}


//Used to postpone requests
Future<bool> _isReadReady() async {
  while (_isWritingToDB > 0) {
    await Future.delayed(Duration(milliseconds: 1));
  }
  return true;
}
