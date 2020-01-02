import 'package:flutter/material.dart';

class Task {
  int id;
  String title;
  bool completed;

  Task({@required this.title, this.completed = false});
//
//  bool toggleCompleted() {
//    return !completed;
//  }

  // Convert a Task into a MAP Object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['completed'] = completed == true ? 1 : 0;
    return map;
  }

  //  Extract a Task from a MAP object
  Task.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.completed = map['completed'] == 1 ? true : false;
  }
}
