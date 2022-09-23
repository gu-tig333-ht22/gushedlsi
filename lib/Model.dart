import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var apiKey = "9a4089a6-201d-42ae-a080-190dc2cbcf49";

class ToDoItem {
  var textdeco = "none"; 
  bool done = false;
  var description;
  var id;

  ToDoItem({required this.done, required this.description, required this.id});

  factory ToDoItem.fromJson(Map<String, dynamic> json) {
    return ToDoItem(
      done: json['done'],
      description: json['title'],
      id: json["id"],
    );
  }
}

class MyState extends ChangeNotifier {
  List<ToDoItem> _list =[]; 
  List<ToDoItem> get list => _list;
  var filtervalue = "all";
  
  void addItem(text) async {
    var response = await http.post(
      Uri.parse(
          'https://todoapp-api.apps.k8s.gu.se/todos?key=$apiKey'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': text.toString(),
        'done': false,
      }),
    );
  _list = (json.decode(response.body) as List)
          .map((hej) => ToDoItem.fromJson(hej))
          .toList();

    notifyListeners();
  }

  void check(ToDoItem card, val) async {
    card.done = val;
    var response = await http.put(
      Uri.parse(
          'https://todoapp-api.apps.k8s.gu.se/todos/${card.id}?key=$apiKey'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'done': val,
        'title': card.description,
      }));
    notifyListeners();

  }

  void removeTodo(ToDoItem todo) async {
    _list.remove(todo);
    var response = await http.delete(
      Uri.parse(
          'https://todoapp-api.apps.k8s.gu.se/todos/${todo.id}?key=9a4089a6-201d-42ae-a080-190dc2cbcf49'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
    print(todo.id);
    notifyListeners();
   }

  void setFilter(value) {
    filtervalue = value;
    notifyListeners();
  }
}

