import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:listmobile/models/listItem.dart';

part 'toDoList.g.dart';

@JsonSerializable()
class ToDoList {
  String name;
  List<ListItem> listItems;
  String category;
  bool active;

  @JsonKey(ignore: true)
  bool _selected;

  //if i want to use the long version i need to use late
  // ListItem({required String name, required int quantity}) {
  //   this.name = name;
  //   this.quantity = quantity;
  // }

  //a short version will be
  ToDoList(
      {required this.name,
      required this.category,
      required this.listItems,
      required this.active,
      selected = false})
      : _selected = selected;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory ToDoList.fromJson(Map<String, dynamic> json) {
    ToDoList collection = _$ToDoListFromJson(json);

    collection._selected = false;

    return collection;
  }

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = _$ToDoListToJson(this);
    result["listItems"] = [...listItems.map((e) => e.toJson())];
    return result;
  }

  // ignore: unnecessary_getters_setters
  bool get selected {
    return _selected;
  }

  set selected(bool newSelectedValue) {
    _selected = newSelectedValue;
  }

  factory ToDoList.createEmpty() {
    return ToDoList(
        name: "", active: true, selected: false, category: "", listItems: []);
  }
}
