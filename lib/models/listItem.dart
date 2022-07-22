import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'listItem.g.dart';

@JsonSerializable()
class ListItem {
  String name;
  int quantity;
  bool lineCross;

  //if i want to use the long version i need to use late
  // ListItem({required String name, required int quantity}) {
  //   this.name = name;
  //   this.quantity = quantity;
  // }

  //a short version will be
  ListItem(
      {required this.name, required this.quantity, this.lineCross = false});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory ListItem.fromJson(Map<String, dynamic> json) =>
      _$ListItemFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$ListItemToJson(this);
}
