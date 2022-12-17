// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:listmobile/db/Repository.dart';
import 'package:listmobile/models/toDoList.dart';
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
        .map((e) => ToDoListCollection.fromJson(e.id, e.data()))
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

  Future<void> setDeleted(String userEmail) async {
    for (var element in _collections) {
      if (element.selected) {
        await _repo.updateField(
            collectionPath: LIST_COLLECTION,
            doc: element.id,
            newValue: {"active": false});
        element.selected = false;
      }
    }
    _showCheckBoxes = false;
    await fetchCollectionsByUser(userEmail);
    notifyListeners();
  }

  bool get showCheckBoxes => _showCheckBoxes;

  List<ToDoListCollection> get collection {
    return [..._collections];
  }

  Future<void> createListInCollection(
      {required String userEmail,
      required String listCollectionId,
      required String name,
      required String category}) async {
    ToDoList newList = ToDoList.createEmpty();
    newList.name = name;
    newList.category = category;
    Map<String, dynamic> list = {
      LIST: [
        ...collection
            .firstWhere((element) => element.id == listCollectionId)
            .lists
            .map((e) => e.toJson()),
        newList.toJson()
      ]
    };
    await _repo.updateField(
        collectionPath: LIST_COLLECTION, doc: listCollectionId, newValue: list);
    await fetchCollectionsByUser(userEmail);
  }

  // Future<void> addList(String listName) async {

  // }
}
