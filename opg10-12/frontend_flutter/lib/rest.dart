import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;


class Food {
  final int id;
  final String name, date, foodCat, foodLoc, userName;

  Food({
      this.id,
      this.name,
      this.date,
      this.foodCat,
      this.foodLoc,
      this.userName
  });

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
  final response = await http.get(
      Uri.encodeFull('http://10.0.2.2:8080/rest/food/user/' +
          userName +
          '/get/' +
          foodId.toString()),
      headers: {"Accept": "application/json"});

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
  String url = 'http://10.0.2.2:8080/rest/food/user/' + userName + '/get';
  Map<String, String> headers = {"Content-type" : "application/json"};

  final response =  await http.get(url, headers: headers);

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
  return http
      .post('http://10.0.2.2:8080/rest/food/user/', body: body)
      .then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode == 201) {
      //400
      return "Food successfully created";
    } else {
      print('Error in food creation');
      print("Error type: " + response.statusCode.toString());
      print(response.body);
      throw Exception('Failed to create food');
    }
  });
}

Future<String> deleteFood(int id, String userName) async {
  return http
      .delete('http://10.0.2.2:8080/rest/food/user/' +
          userName +
          '/delete/' +
          id.toString())
      .then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode == 200) {
      //400
      return "Food successfully deleted"; //Post.fromJson(json.decode(response.body));

    } else {
      print("Error in deletion");
      print("Error type: " + response.statusCode.toString());
      print(response.body);
      throw Exception("Something went wrong");
    }
  });
}

Future<String> deleteAllFoods(String userName, String location) async {
  return http
      .delete('http://10.0.2.2:8080/rest/food/users/' +
          userName +
          '/delete/all/' +
          location)
      .then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode == 200) {
      return "All your foods have successfully been deleted. Feel hungry yet?"; //Post.fromJson(json.decode(response.body));
    } else {
      print("Error in deletion");
      print("Error type: " + response.statusCode.toString());
      print(response.body);
      throw Exception("Something went wrong");
    }
  });
}

Future<String> sendPut(
    String userName, String foodId, Map<String, String> headers) {
  return http
      .put(
          'http://10.0.2.2:8080/rest/food/users/' + userName + '/put/' + foodId,
          headers: headers)
      .then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode == 200) {
      //400
      return "The food item has been updated"; //Food.PutFromJson(userName, id,json.decode(response.body));
    } else {
      print("Error when updating");
      print("Error type: " + response.statusCode.toString());
      print(response.body);
      throw Exception("Something went wrong");
    }
  });
}
