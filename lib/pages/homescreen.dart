import 'package:flutter/material.dart';
import 'package:todoapp/utils/dialog_box.dart';

import '../utils/todo_tile.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  //text controller
  final _controller = TextEditingController();
//list of items
  List toDolist = [
    ["code", true],
    ["learn", false]
  ];

  void checkboxchanged(bool? value, int index) {
    setState(() {
      toDolist[index][1] = !toDolist[index][1];
    });
  }
// save task
void saveNewTask(){ 
setState(() {
  toDolist.add([_controller.text,false]);
  _controller.clear();
});
Navigator.of(context).pop();
}
// create new task dialogbox
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }
  //delete task
  void deleteTask(int index){
    setState(() {
          toDolist.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        title: Center(
            child: Text(
          "TO DO",
          style: TextStyle(color: Colors.white),
        )),
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.deepPurple,
        ),
        onPressed: () {
          createNewTask();
        },
      ),
      body: SafeArea(
          child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: toDolist.length,
            itemBuilder: (context, index) {
              return ToDoTile(
                taskName: toDolist[index][0],
                taskComplted: toDolist[index][1],
                onChanged: (value) => checkboxchanged(value, index),
                deleteFunction: (context) => deleteTask(index),
              );
            },
          )
        ],
      )),
    );
  }
}
