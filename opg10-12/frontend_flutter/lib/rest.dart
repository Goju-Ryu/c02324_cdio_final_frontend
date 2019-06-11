import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Message> get() async{
  final response = await http.get(
    Uri.encodeFull('http://10.0.2.2:8080/rest/hello/1'),
      headers:{
        "Accept": "application/json"
      }
  );

  if (response.statusCode == 200) {
    //if server returns okay
    return Message.fromJson(json.decode(response.body));
  } else {
    //if response was not okay, throw an error
    print('Error in fetchMessage');
    print (response.body);
    throw Exception('Failed to load Message');
  }
}

class Post {
  final int id;
  final String name, date, foodCat, foodLoc, userName;
  final double amount;

  Post({this.id, this.name, this.date, this.foodCat, this.foodLoc, this.userName, this.amount});

  factory Post.fromJson(Map<String, dynamic> json){
    return Post(
      id: json['id'],
      name: json['name'],
      date: json['date'],
      foodCat: json['foodCat'],
      foodLoc: json['foodLoc'],
      userName: json['userName'],
      amount: json['amount']
    );
  }

  Map toMap(){
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['date'] = date;
    map['foodCat'] = foodCat;
    map['foodLoc'] = foodLoc;
    map['userName'] = userName;
    map['amount'] = amount;

    return map;
  }
}

Future<Post> sendPost(String url, {Map body}) async{
    return http.post(url, body: body).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode != 201){
        throw Exception("Something went wrong");
      }
      return Post.fromJson(json.decode(response.body));
    });
}


class Message {
  final int id;
  final String name, date, foodCat, foodLoc, userName;
  final double amount;

  Message({this.id, this.name, this.date, this.foodCat, this.foodLoc, this.userName, this.amount});



  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] == null ? null : json['id'],
      name: json['name'] == null ? null : json['name'],
      date: json['date'] == null ? null : json['date'],
      foodCat: json['foodCat'] == null ? null : json['foodCat'],
      foodLoc: json['foodLoc'] == null ? null : json['foodLoc'],
      userName: json['userName'] == null ? null : json['userName'],
      amount: json['amount'] == null ? null : json['amount']
    );
  }
}


/*
FoodDTO food = foodDTOMap.get(id);
        JsonObject jsonObject = new JsonObject();
        jsonObject.addProperty("id", food.getID());
        jsonObject.addProperty("name", food.getName());
        jsonObject.addProperty("expDate", DTS.dateToString(10, 06, 2019));
        String foodCat = food.getCategory().toString();
        String foodLoc = food.getLocation().toString();
        jsonObject.addProperty("category", foodCat);
        jsonObject.addProperty("location", foodLoc);
        System.out.println(jsonObject.toString());
        return jsonObject.toString();
 */
