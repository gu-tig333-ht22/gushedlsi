import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var apiKey = "9a4089a6-201d-42ae-a080-190dc2cbcf49";

class ToDoItem {
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
  
  void addItem(input) async {
    var response = await http.post(
      Uri.parse(
          'https://todoapp-api.apps.k8s.gu.se/todos?key=$apiKey'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': input.toString(),
        'done': false,
      }),
    );
  updateList();
  }

  void check(ToDoItem todo, val) async {
    await http.put(
      Uri.parse(
          'https://todoapp-api.apps.k8s.gu.se/todos/${todo.id}?key=$apiKey'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'done': val,
        'title': todo.description,
      }));
    updateList();

  }

  void removeTodo(ToDoItem todo) async {
    await http.delete(
      Uri.parse(
          'https://todoapp-api.apps.k8s.gu.se/todos/${todo.id}?key=$apiKey'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
    updateList();
   }

  void setFilter(value) {
    filtervalue = value;
    notifyListeners();
  }

  void updateList() async  {
    var response = await http.get(
      Uri.parse(
          'https://todoapp-api.apps.k8s.gu.se/todos/?key=$apiKey'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },);
    _list = (json.decode(response.body) as List)
          .map((item) => ToDoItem.fromJson(item))
          .toList();

    notifyListeners();
  }
}

