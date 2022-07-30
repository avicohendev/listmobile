// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:listmobile/db/Repository.dart';
import 'package:listmobile/models/toDoListCollection.dart';
import 'package:provider/provider.dart';

import '../common/constants.dart';

class TodoListCollectionProvider with ChangeNotifier {
  TodoListCollectionProvider(this._repo, this._collections);

  final Repository _repo;
  List<ToDoListCollection> _collections;

  fetchCollection(String userName) async {
    final newCollection = await _repo.getCollectionWithCondition(
        LIST_COLLECTION, "users", userName);
    _collections = newCollection
        .map((e) => ToDoListCollection.fromJson(e.data()))
        .toList();
  }
}
