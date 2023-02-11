import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:listmobile/models/toDoList.dart';
import 'package:listmobile/models/toDoListCollection.dart';
import 'package:listmobile/providers/ListCollectionProvider.dart';
import 'package:listmobile/screens/lists/CollectionAndLists.dart';
import 'package:listmobile/screens/lists/listAndItems.dart';
import 'package:provider/provider.dart';

class ListCard extends StatefulWidget {
  final String collectionId;
  final int listLocation;
  const ListCard(
      {Key? key, required this.listLocation, required this.collectionId})
      : super(key: key);

  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoListCollectionProvider>(
      builder: (context, value, child) {
        ToDoList _currentCollection = value.collection
            .firstWhere((element) => element.id == widget.collectionId)
            .lists[widget.listLocation];
        return ListTile(
          leading: value.showCheckBoxes
              ? Checkbox(
                  value: _currentCollection.selected,
                  onChanged: (_) => value.changeSelection(
                      widget.listLocation, !_currentCollection.selected))
              : null,
          key: Key("collection_" + _currentCollection.name),
          dense: true,
          title: Text(_currentCollection.name),
          subtitle: Text(_currentCollection.category),
          onTap: () {
            print("click");
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ListAndItems(
                    collectionId: widget.collectionId,
                    listName: _currentCollection.name)));
          },
          onLongPress: () {
            print("long press");
            value.changeSelection(
                widget.listLocation, !_currentCollection.selected);
          },
        );
      },
    );
  }
}
