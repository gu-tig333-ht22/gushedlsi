import 'package:flutter/material.dart';

void main() {
  runApp(Myapp());
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
        title: Text("TIG 333 TODO", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.grey[400],
        actions: [
          _popMenu()
  ] 
      ),
      body: Center(
          child: Column(children: [
        Container(height: 10,),
        _todoRow(),
        Divider(
          color: Colors.black,
        ),
        _todoRow(),
        Divider(
          color: Colors.black,
        ),
    

        Expanded(
            child: Align(
          alignment: FractionalOffset.bottomRight,
          child: Container(
            margin: EdgeInsets.only(right: 30, bottom: 30),
            child: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SecondView()));
              })),
        ))
      ])),
    );
  }

  Widget _popMenu() {
    return PopupMenuButton(
          icon: Icon(Icons.more_vert),
          itemBuilder: (context){
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
          }
        );
  }

  Widget _todoRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Checkbox(
          value: false,
          onChanged: (val) {},
        ),
        Text("Mjölk"),
        Container(
          margin:EdgeInsets.only(right: 10) ,
          child: ElevatedButton(onPressed: () {}, child: Icon(Icons.clear)))
      ],
    );
  }

  Widget plusButton() { //Dennaa används ej, pga navigator funkar ej här
    return Positioned(
        bottom: 30,
        right: 30,
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            /* Navigator.push(context,
          MaterialPageRoute(builder: (context) => SecondView()));
        */
          },
        ));
  }
}

//SECOND VIEW
class SecondView extends StatelessWidget {
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
            ElevatedButton(onPressed: () {}, child: Text("+ ADD"))
      ])),
    );
  }

  Widget todoInput() {
    return Container(
            margin: EdgeInsets.only(left: 40.0, right: 40),
            child: TextField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2)),
                  hintText: "Vad mer behöver du göra?"),
            ));
  }


}
