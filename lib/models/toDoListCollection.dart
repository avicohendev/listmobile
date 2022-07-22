import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:listmobile/models/listItem.dart';
import 'package:listmobile/models/toDoList.dart';

part 'toDoListCollection.g.dart';

@JsonSerializable()
class ToDoListCollection {
  List<String> users;
  List<ToDoList> lists;

  //if i want to use the long version i need to use late
  // ListItem({required String name, required int quantity}) {
  //   this.name = name;
  //   this.quantity = quantity;
  // }

  //a short version will be
  ToDoListCollection({required this.users, required this.lists});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory ToDoListCollection.fromJson(Map<String, dynamic> json) =>
      _$ToDoListCollectionFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$ToDoListCollectionToJson(this);
}
