import 'package:flutter/material.dart';

class ToDoItem {
  String description;
  bool done = false;
  var textdeco = "none"; 

  ToDoItem(this.description);
}

class MyState extends ChangeNotifier {
  List<ToDoItem> _list =[];

  List<ToDoItem> get list => _list;

  void addItem(ToDoItem card) {
    _list.add(card);
    notifyListeners();
  }

  void check(card, val) {
    card.done = val;
    notifyListeners();

  }

  void removeTodo(ToDoItem todo) {
    _list.remove(todo);
    notifyListeners();
   }



}