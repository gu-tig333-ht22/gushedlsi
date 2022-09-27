import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './SecondView.dart';
import 'Model.dart';
import 'package:provider/provider.dart';

void main() {
  var state = MyState();
  state.updateList(); //Skapar lista i MyState från API
  runApp(ChangeNotifierProvider(create: (context) => state, child: Myapp()));
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainView(),
    );
  }
}

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("TIG 333 TODO", style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.grey[400],
            actions: [_popMenu()]),
        body: ToDoListView(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            var inputText = await Navigator.push( 
                context, MaterialPageRoute(builder: (context) => SecondView()));
            if (inputText != null && inputText != "") { //Skapar endast ett item  
              Provider.of<MyState>(context, listen: false).addItem(inputText);
            }
          },
        ));
    ;
  }

  Widget _popMenu() {
    return Consumer<MyState>(
        builder: (context, state, child) => PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (value) {
              Provider.of<MyState>(context, listen: false)
                  .setFilter(value);
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text("All"),
                  value: "all",
                ),
                PopupMenuItem(
                  child: Text("Done"),
                  value: "done",
                ),
                PopupMenuItem(
                  child: Text("Undone"),
                  value: "undone",
                ),
              ];
            }));
  }
}

class ToDoList extends StatelessWidget {
  final List<ToDoItem> list;

  ToDoList(this.list);

  Widget build(BuildContext context) {
    //Bygger upp en list view
    return Consumer<MyState>(
        builder: (context, state, child) => ListView(
            children: _filterList(list, state.filtervalue)
                .map((card) => _ToDoItem(card))
                .toList()));
  }

  Widget _ToDoItem(card) { //Utseendet på varje rad 
    return Consumer<MyState>(
        builder: (context, state, child) =>
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Checkbox(
                value: card.done,
                onChanged: (val) {
                  Provider.of<MyState>(context, listen: false).check(card, val);
                },
              ),
              text(card),
              Container(
                  margin: EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                      onPressed: () {
                        Provider.of<MyState>(context, listen: false)
                            .removeTodo(card);
                      },
                      child: Icon(Icons.clear,)))
            ]));
  }

  List<ToDoItem> _filterList(list, filterBy) { //Funktion som returnerar en lista utifrån hur filtret är inställt 
    if (filterBy == 'done')
      return list.where((item) => item.done == true).toList();
    if (filterBy == 'undone')
      return list.where((item) => item.done == false).toList();
    else
      return list;
  }

  Widget text(card) { //Widget funktion som returnerar en text som är "nomal" elelr överstrucken
    if (card.done == true) {
      return Text(card.description,
          style: TextStyle(decoration: TextDecoration.lineThrough));
    } else {
      return Text(card.description,
          style: TextStyle(decoration: TextDecoration.none));
    }
  }
}

class ToDoListView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<MyState>(
        //Addar listan från state till listan i main tror jag
        builder: (context, state, child) => ToDoList(state.list));
  }
}
