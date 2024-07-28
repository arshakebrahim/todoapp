import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase{
  List toDolist = [];

// reference hive 
final _myBox = Hive.box('mybox');

// default data when the app opens first time ever
void createInitialData(){
  toDolist = [
    ["start coding", false],
    ["do your exercise buddy", false]
  ];
}

//load data from the database
void loadData(){
  toDolist = _myBox.get("TODOLIST");
}

//update database
void updateDataBase(){
  _myBox.put("TODOLIST", toDolist);
}

}