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
        title: Text("TIG 169 TODO", 
        style: TextStyle(
          color: Colors.black 
            )
          ),
        backgroundColor: Colors.grey[400],
      ) ,
      body: Center(
        child: Column(children: [
          _todoRow(),
          Divider(color: Colors.black,),
          _todoRow(),
          Divider(color: Colors.black,),
          //plusButton(),
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => SecondView()));}),
          
        ]
        )
      ),

    );
  }

  Widget _todoRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Checkbox(
          value: false, 
          onChanged: (val) {},
          ),
        Text("Mjölk"),
        ElevatedButton(onPressed: (){}, child: Icon(Icons.clear))
      ],
    );
  }

  Widget plusButton() {
    return Positioned(
      bottom: 30,
      right: 30,
      child: 
      FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
         /* Navigator.push(context,
          MaterialPageRoute(builder: (context) => SecondView()));
        */},
        
       )
    );
  }

}

class SecondView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TIG 169 TODO", 
        style: TextStyle(
          color: Colors.black 
          )
          ),
        backgroundColor: Colors.grey[400],
      ) ,
      body: Center(
        child: Column(children: [
          Container( //FKYTTAS TILL SECOND VIEW, MEN VARFÖR FUNKAR EJ MARGINS? 
            margin: EdgeInsets.only(left: 40.0, right: 40) ,
            child: TextField(
              decoration: InputDecoration( 
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2)
                ), 
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2)
                ),
                hintText: "Vad mer behöver du göra?" 
              ),
            )
          ) //SKA FLYTTAS HELA VÄGEN HIT 
        ]
        )
      ),

    ); 
  }
}

