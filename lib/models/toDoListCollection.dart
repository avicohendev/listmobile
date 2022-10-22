import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:listmobile/models/listItem.dart';
import 'package:listmobile/models/toDoList.dart';

part 'toDoListCollection.g.dart';

@JsonSerializable()
class ToDoListCollection {
  List<String> users;
  List<ToDoList> lists;
  String name;

  @JsonKey(ignore: true)
  bool _selected;

  //if i want to use the long version i need to use late
  // ListItem({required String name, required int quantity}) {
  //   this.name = name;
  //   this.quantity = quantity;
  // }

  //a short version will be
  ToDoListCollection(
      {required this.users,
      required this.lists,
      required this.name,
      selected = false})
      : _selected = selected;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory ToDoListCollection.fromJson(Map<String, dynamic> json) {
    ToDoListCollection collection = _$ToDoListCollectionFromJson(json);
    collection._selected = false;
    return collection;
  }

  // ignore: unnecessary_getters_setters
  bool get selected {
    return _selected;
  }

  set selected(bool newSelectedValue) {
    _selected = newSelectedValue;
  }

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$ToDoListCollectionToJson(this);

  factory ToDoListCollection.createEmpty() {
    return ToDoListCollection(users: [], lists: [], name: "", selected: false);
  }
}
