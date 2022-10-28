// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:listmobile/db/Repository.dart';
import 'package:listmobile/models/toDoListCollection.dart';
import 'package:provider/provider.dart';

import '../common/constants.dart';

class TodoListCollectionProvider extends ChangeNotifier {
  TodoListCollectionProvider({required repo, showCheckBoxes = false})
      : _showCheckBoxes = showCheckBoxes,
        _repo = repo;

  final Repository _repo;
  late List<ToDoListCollection> _collections;
  bool _showCheckBoxes;

  Future<void> fetchCollectionsByUser(String userEmail) async {
    final newCollection = await _repo.getCollectionWithInCondition(
        LIST_COLLECTION, "users", userEmail);
    _collections = newCollection
        .map((e) => ToDoListCollection.fromJson(e.data()))
        .toList();
    notifyListeners();
  }

  Future<void> createColection(ToDoListCollection newCollection) async {
    await _repo.setData(LIST_COLLECTION, newCollection.toJson());
    await fetchCollectionsByUser(newCollection.users[0]);
  }

  Future<void> createNewListCollection(
      {required String collectionName, required String email}) async {
    ToDoListCollection newCollection = ToDoListCollection.createEmpty();
    newCollection.name = collectionName;
    newCollection.lists = [];
    newCollection.users = [email];

    await createColection(newCollection);
  }

  changeSelection(int location, bool newSelectionValue) {
    _collections[location].selected = newSelectionValue;
    _changeCheckBoxState();
    notifyListeners();
  }

  _changeCheckBoxState() {
    _showCheckBoxes = _collections.any((element) => element.selected == true);
  }

  bool get showCheckBoxes => _showCheckBoxes;

  List<ToDoListCollection> get collection {
    return [..._collections];
  }
}
