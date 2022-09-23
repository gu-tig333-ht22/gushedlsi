import 'package:flutter/material.dart';
import 'Model.dart';


class SecondView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SecondViewState();

}
class _SecondViewState extends State<SecondView> {

  TextEditingController todoController = TextEditingController(); 

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TIG 333 TODO", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.grey[400],
      ),
      body: Center(
          child: Column(children: [
            Container(height: 30,),
            todoInput(),
            Container(height: 30,),
            ElevatedButton(onPressed: () {
              Navigator.pop(context, todoController.text); 
            }, child: Text("+ ADD"))
      ])),
    );
  }

  Widget todoInput() {
    return Container(
            margin: EdgeInsets.only(left: 40.0, right: 40),
            child: TextField(
              controller: todoController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2)),
                  labelText: "Vad mer behöver du göra?"),
            ));
  }

}


