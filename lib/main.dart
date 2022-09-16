import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './SecondView.dart';
import 'Model.dart';
import 'package:provider/provider.dart';

void main() {
  var state = MyState();
  runApp(ChangeNotifierProvider(create: (context) => state, child: Myapp()));
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainView(),
    );
  }
}

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("TIG 333", style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.grey[400],
            actions: [_popMenu()]),
        body: ToDoListView(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            //Tanken är att den här ska ta emot ett nytt todoitem
            var testvar = await Navigator.push(
                context, MaterialPageRoute(builder: (context) => SecondView()));
            if (testvar != null) {
              Provider.of<MyState>(context, listen: false)
                  .addItem(ToDoItem(testvar));
            }
          },
        ));
    ;
  }

  Widget _popMenu() {
    return PopupMenuButton(
        icon: Icon(Icons.more_vert),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              child: Text("All"),
            ),
            PopupMenuItem(
              child: Text("Done"),
            ),
            PopupMenuItem(
              child: Text("Undone"),
            ),
          ];
        });
  }
}

class ToDoList extends StatelessWidget {
  final List<ToDoItem> list;

  ToDoList(this.list);

  Widget build(BuildContext context) {
    return ListView(children: list.map((card) => _ToDoItem(card)).toList());
  }

  Widget _ToDoItem(card) {
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
                      child: Icon(Icons.clear)))
            ]));
  }

  Widget text(card) {
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
        builder: (context, state, child) => ToDoList(state.list));
  }
}
