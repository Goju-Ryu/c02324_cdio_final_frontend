import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

final String _root = 'http://10.0.2.2:8080/rest/food/user/';

class Food {
  final int id;
  final String name, date, foodCat, foodLoc, userName;

  Food(
      {this.id,
      this.name,
      this.date,
      this.foodCat,
      this.foodLoc,
      this.userName});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      name: json['name'],
      date: json['expDate'],
      foodCat: json['category'],
      foodLoc: json['location'],
      userName: json['userName'],
    );
  }
}

Future<Food> get(String userName, int foodId) async {
  String url = _root + userName + '/get/' + foodId.toString();
  Map<String, String> headers = {"Content-type": "application/json"};

  final response = await http.get(url, headers: headers);

  /*
  final response = await http.get(
      Uri.encodeFull(_root +
          userName +
          '/get/' +
          foodId.toString()),
      headers: {"Accept": "application/json"});
*/

  if (response.statusCode == 200) {
    //404
    //if server returns okay
    return Food.fromJson(json.decode(response.body));
  } else {
    //if response was not okay, throw an error
    print('Error in fetchMessage');
    print("Error type: " + response.statusCode.toString());
    print(response.body);
    throw Exception('Failed to load Message');
  }
}

Future<List<Food>> getList(String userName) async {
  print("Kommer den her bd?");
  String url = _root + userName + '/get';
  Map<String, String> headers = {"Content-type": "application/json"};

  final response = await http.get(url, headers: headers);

  print("på den anden side.");
  print(response != null ? response.body : "Den er null");
/*
  final response = await http.get(
      Uri.encodeFull(
          'http://10.0.2.2:8080/rest/food/user/' + userName + '/get'),
      headers: {"Accept": "application/json"});
*/

  if (response.statusCode == 200) {
    //400
    //if server returns okay
    Iterable foods = json.decode(response.body); //Henrik
    return foods
        .map((foodElement) => Food.fromJson(foodElement))
        .toList(); //Henrik
  } else {
    //if response was not okay, throw an error
    print('Error in fetchMessage');
    print("Error type: " + response.statusCode.toString());
    print(response.body);
    throw Exception('Failed to load Message');
  }
}

Future<String> sendPost(String userName, {Map body}) async {
  String url = _root;
  body = {"Content-type": "application/json"};

  final response = await http.post(url, body: body);

/*
  return http
      .post(_root, body: body)
      .then((http.Response response) {
    final int statusCode = response.statusCode;
*/
  if (response.statusCode == 201) {
    return "Food successfully created";
  } else {
    print('Error in food creation');
    print("Error type: " + response.statusCode.toString());
    print(response.body);
    throw Exception('Failed to create food');
  }
}

Future<String> deleteFood(int foodId, String userName) async {
  String url = _root + userName + '/delete/' + foodId.toString();

  final response = await http.delete(url);

  /*
  return http
      .delete(_root +
          userName +
          '/delete/' +
          id.toString())
      .then((http.Response response) {
    final int statusCode = response.statusCode;
*/
  if (response.statusCode == 200) {
    return "Food successfully deleted"; //Post.fromJson(json.decode(response.body));

  } else {
    print("Error in deletion");
    print("Error type: " + response.statusCode.toString());
    print(response.body);
    throw Exception("Something went wrong");
  }
}

Future<String> deleteAllFoods(String userName, String location) async {
  String url = _root + userName + '/delete/all/' + location;
  final response = await http.delete(url);

  /*return http
      .delete(_root +
          userName +
          '/delete/all/' +
          location)
      .then((http.Response response) {
    final int statusCode = response.statusCode;
*/
  if (response.statusCode == 200) {
    return "All your foods have successfully been deleted. Feel hungry yet?"; //Post.fromJson(json.decode(response.body));
  } else {
    print("Error in deletion");
    print("Error type: " + response.statusCode.toString());
    print(response.body);
    throw Exception("Something went wrong");
  }
}

Future<String> sendPut(
    String userName, int foodId, Map<String, String> headers) async {
  String url = _root + userName + '/put/' + foodId.toString();
  final response = await http.put(url, headers: headers);

  /*
  return http
      .put(
          _root + userName + '/put/' + foodId,
          headers: headers)
      .then((http.Response response) {
    final int statusCode = response.statusCode;
*/
  if (response.statusCode == 200) {
    //400
    return "The food item has been updated"; //Food.PutFromJson(userName, id,json.decode(response.body));
  } else {
    print("Error when updating");
    print("Error type: " + response.statusCode.toString());
    print(response.body);
    throw Exception("Something went wrong");
  }
}
