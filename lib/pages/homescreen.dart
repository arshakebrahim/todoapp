import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/data/database.dart';
import 'package:todoapp/utils/dialog_box.dart';

import '../utils/todo_tile.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  //reference hive 
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // TODO: implement initState
   if(_myBox.get("TODOLIST") == null){
    db.createInitialData();
   } else{
    db.loadData();
   }
    super.initState();
  }
  //text controller
  final _controller = TextEditingController();

  void checkboxchanged(bool? value, int index) {
    setState(() {
      db.toDolist[index][1] = !db.toDolist[index][1];
    });
    db.updateDataBase();
  }
// save task
void saveNewTask(){ 
setState(() {
  db.toDolist.add([_controller.text,false]);
  _controller.clear();
});
Navigator.of(context).pop();
db.updateDataBase();
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
          db.toDolist.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        title: const Center(
            child: Text(
          "TO DO",
          style: TextStyle(color: Colors.white),
        )),
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
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
            itemCount: db.toDolist.length,
            itemBuilder: (context, index) {
              return ToDoTile(
                taskName: db.toDolist[index][0],
                taskComplted: db.toDolist[index][1],
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
