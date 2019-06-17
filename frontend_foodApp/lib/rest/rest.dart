import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

final String _root = 'http://10.0.2.2:8080/rest/ingredient';

class FoodDTO {
  final int foodId;
  final String foodName, userName, expDate, location, category;

  FoodDTO({this.foodId, this.foodName, this.userName, this.expDate, this.location, this.category});

  factory FoodDTO.fromJson(Map<String, dynamic> json) {
    return FoodDTO(
      foodId: json['id'],
      foodName: json['name'],
      userName: json['userName'],
      expDate: json['expDate'],
      location: json['location'],
      category: json['category']
    );
  }
}

Future<FoodDTO> get(int foodId) async {
  String url = _root + "/" + foodId.toString();
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

Future<List<FoodDTO>> getList() async {
  String url = _root;
  Map<String, String> headers = {"Content-type": "application/json"};

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    //400
    //if server returns okay
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

Future<String> sendPost({Map<String, String> ingredient}) async {
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

Future<String> sendPut(int ingredientId) async {
  String url = _root + "/" + ingredientId.toString();
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
