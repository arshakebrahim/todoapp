import 'package:flutter/material.dart';
import 'package:todoapp/utils/dialog_box.dart';

import '../utils/todo_tile.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
//list of items
List toDolist = [
  ["code", true],
  ["learn", false]
];

void checkboxchanged(bool? value, int index){
  setState(() {
    toDolist[index][1] = ! toDolist[index][1];
  });
}

void createNewTask(){
  showDialog(context: context, builder: (context) {
    return DialogBox();
  },);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        title: Center(child: Text("TO DO",style: TextStyle(color: Colors.white),)),
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButton: 
      FloatingActionButton(
        child: Icon(Icons.add, color: Colors.deepPurple,),
        onPressed: () {
        createNewTask();
      },) ,
      body: SafeArea(child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: toDolist.length,
            itemBuilder: (context, index) {
              return ToDoTile(
                taskName: toDolist[index][0],
                taskComplted: toDolist[index][1],
                onChanged: (value) =>checkboxchanged(value, index),
              );
            },)
        ],
      )),
    );
  }
}