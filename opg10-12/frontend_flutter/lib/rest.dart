import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

final String _root = 'http://10.0.2.2:8080/rest/ingredient';

class Ingredient {
  final int id;
  final double amount;
  final String name;

  Ingredient({this.id, this.name, this.amount});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      name: json['name'],
      amount: json['amount'],
    );
  }
}

Future<Ingredient> get(int foodId) async {
  String url = _root + "/" + foodId.toString();
  Map<String, String> headers = {"Content-type": "application/json"};

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    //404
    //if server returns okay
    return Ingredient.fromJson(json.decode(response.body));
  } else {
    //if response was not okay, throw an error
    print('Error in fetchMessage');
    print("Error type: " + response.statusCode.toString());
    print(response.body);
    throw Exception('Failed to load Message');
  }
}

Future<List<Ingredient>> getList() async {
  String url = _root;
  Map<String, String> headers = {"Content-type": "application/json"};

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    //400
    //if server returns okay
    Iterable foods = json.decode(response.body); //Henrik
    return foods
        .map((foodElement) => Ingredient.fromJson(foodElement))
        .toList(); //Henrik
  } else {
    //if response was not okay, throw an error
    print('Error in fetchMessage');
    print("Error type: " + response.statusCode.toString());
    print(response.body);
    throw Exception('Failed to load Message');
  }
}

Future<String> sendPost({Map body}) async {
  String url = _root;
  body = {"Content-type": "application/json"};

  final response = await http.post(url, body: body);

  if (response.statusCode == 201) {
    return "Food successfully created";
  } else {
    print('Error in food creation');
    print("Error type: " + response.statusCode.toString());
    print(response.body);
    throw Exception('Failed to create food');
  }
}

Future<String> delete(int foodId) async {
  String url = _root + "/" + foodId.toString();
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

Future<String> sendPut(int ingredientId, Map<String, String> headers) async {
  String url = _root + ingredientId.toString();
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
