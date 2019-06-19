import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:semester2_cdio_final/util/foodDTO.dart';

final String _root = 'http://10.16.167.245:8080/rest/food/user';



Future<FoodDTO> getFood(String userName, int foodId) async {
  String url = _root + "/" + userName + "/get/" + foodId.toString();
  Map<String, String> headers = {"Content-type": "application/json"};

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    //404
    //if server returns okay
    return FoodDTO.fromJson(json.decode(response.body));
  } else {
    //if response was not okay, throw an error
    print('Error in fetchMessage');
    print("Error type: " + response.statusCode.toString());
    print(response.body);
    throw Exception('Failed to load Message');
  }
}

Future<List<FoodDTO>> getExpiredFood(String userName, int days) async {
  String url = _root + "/" + userName + "/get/expire/" + days.toString();
  Map<String, String> headers = {"Content-type": "application/json"};
  print("før");
  final response = await http.get(url, headers: headers);
    print("på den anden side");
  if (response.statusCode == 200) {
    //400
    //if server returns okay
    print("wuhu");
    Iterable foods = json.decode(response.body); //Henrik
    return foods
        .map((foodElement) => FoodDTO.fromJson(foodElement))
        .toList(); //Henrik
  } else {
    //if response was not okay, throw an error
    print('Error in fetchMessage');
    print("Error type: " + response.statusCode.toString());
    print(response.body);
    throw Exception('Failed to load Message');
  }
}

Future<List<FoodDTO>> getFoodList(String userName, int location) async {
  String url = _root + "/" + userName + "/get/storage/" + location.toString();
  Map<String, String> headers = {"Content-type": "application/json"};

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    //400
    //if server returns okay
    Iterable foods = json.decode(response.body); //Henrik
    print("got response: " + response.body);
    return foods
        .map((foodElement) => FoodDTO.fromJson(foodElement))
        .toList(); //Henrik
  } else {
    //if response was not okay, throw an error
    print('Error in fetchMessage');
    print("Error type: " + response.statusCode.toString());
    print(response.body);
    throw Exception('Failed to load Message');
  }
}

Future<String> addFood({Map<String, String> ingredient}) async {
  String url = _root;
  Map<String, String> header = {"Content-type": "application/json"};

  final response = await http.post(url, headers: header, body: jsonEncode(ingredient), encoding: Encoding.getByName("json"));

  if (response.statusCode == 200) {
    return "Food successfully created";
  } else {
    print('Error in food creation');
    print("Error type: " + response.statusCode.toString());
    print(response.body);
    throw Exception('Failed to create food');
  }
}

Future<String> deleteFood(String userName, int foodId) async {
  String url = _root + "/" + userName + "/delete/" + foodId.toString();
  print(url);
  final response = await http.delete(url);

  if (response.statusCode == 200) {
    return "Food successfully deleted"; //Post.fromJson(json.decode(response.body));

  } else {
    print("Error in deletion");
    print("Error type: " + response.statusCode.toString());
    print(response.body);
    throw Exception("Something went wrong");
  }
}

Future<String> deleteAllFood(String userName, String location) async {
  String url = _root + "/" + userName + "/delete/all/" + location;
  print(url);
  final response = await http.delete(url);

  if (response.statusCode == 200) {
    return "Food successfully deleted"; //Post.fromJson(json.decode(response.body));

  } else {
    print("Error in deletion");
    print("Error type: " + response.statusCode.toString());
    print(response.body);
    throw Exception("Something went wrong");
  }
}

Future<String> updateFood(String userName, int ingredientId) async {
  String url = _root + "/" + userName + "/put/" + ingredientId.toString();
  Map<String, String> headers = {"Content-type": "application/json"};
  final response = await http.put(url, headers: headers);

  if (response.statusCode == 200) {
    //400
    return "The food item has been updated";
  } else {
    print("Error when updating");
    print("Error type: " + response.statusCode.toString());
    print(response.body);
    throw Exception("Something went wrong");
  }
}

Future<String> addUser (String userName) async{
  String url = _root + "/" + userName + "/add";
  print(url);

  Map<String, String> header = {"Content-type": "application/json"};

  final response = await http.post(url, headers: header, body: jsonEncode(userName), encoding: Encoding.getByName("json"));

  if (response.statusCode == 201) {
    return "User successfully created";
  } else {
    print('Error in user creation');
    print("Error type: " + response.statusCode.toString());
    print(response.body);
    throw Exception('Failed to create user');
  }

}

Future<String> deleteUser(String userName) async {
  String url = _root + "/" + userName + "/delete";
  print(url);
  final response = await http.delete(url);

  if (response.statusCode == 200) {
    return "User successfully deleted"; //Post.fromJson(json.decode(response.body));

  } else {
    print("Error in deletion");
    print("Error type: " + response.statusCode.toString());
    print(response.body);
    throw Exception("Something went wrong");
  }
}

Future<bool> verifyUser(String userName) async {
  String url = _root + "/" + userName + "/get/verify";
  print(url);

  final response = await http.get(url);

  if (response.statusCode == 200) {
    //if server returns okay
    return true;
  } else if (response.statusCode == 404) {
    //user doesn't exist
    return false;
  } else {
    //if response was not okay, throw an error
    print('User does not exist');
    print("Error type: " + response.statusCode.toString());
    print(response.body);
    throw Exception('User does not exist');
  }
}
