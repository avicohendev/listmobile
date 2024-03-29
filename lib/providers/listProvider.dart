// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:listmobile/db/Repository.dart';
// import 'package:listmobile/models/toDoListCollection.dart';
// import 'package:provider/provider.dart';

// import '../common/constants.dart';

// class TodoListProvider extends ChangeNotifier {
//   TodoListProvider(this._repo);

//   Repository _repo;
//   late List<TodoListProvider> _list;

//   Future<void> fetchCollectionsByUser(String userEmail) async {
//     final newCollection = await _repo.getCollectionWithInCondition(
//         LIST_COLLECTION, "users", userEmail);
//     _collections = newCollection
//         .map((e) => ToDoListCollection.fromJson(e.data()))
//         .toList();
//     notifyListeners();
//   }

//   Future<void> createColection(ToDoListCollection newCollection) async {
//     await _repo.setData(LIST_COLLECTION, newCollection.toJson());
//     await fetchCollectionsByUser(newCollection.users[0]);
//   }

//   Future<void> createNewListCollection(
//       {required String collectionName, required String email}) async {
//     ToDoListCollection newCollection = ToDoListCollection.createEmpty();
//     newCollection.name = collectionName;
//     newCollection.lists = [];
//     newCollection.users = [email];

//     await createColection(newCollection);
//   }

//   List<ToDoListCollection> getCollection() {
//     return [..._collections];
//   }
// }