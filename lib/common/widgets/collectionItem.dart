import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:listmobile/models/toDoListCollection.dart';
import 'package:listmobile/providers/ListCollectionProvider.dart';
import 'package:provider/provider.dart';

class CollectionItem extends StatefulWidget {
  final int collectionLocation;
  const CollectionItem({
    Key? key,
    required this.collectionLocation,
  }) : super(key: key);

  @override
  State<CollectionItem> createState() => _CollectionItemState();
}

class _CollectionItemState extends State<CollectionItem> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoListCollectionProvider>(
      builder: (context, value, child) {
        ToDoListCollection _currentCollection =
            value.collection[widget.collectionLocation];
        return ListTile(
          leading: value.showCheckBoxes
              ? Checkbox(
                  value: _currentCollection.selected,
                  onChanged: (_) => value.changeSelection(
                      widget.collectionLocation, !_currentCollection.selected))
              : null,
          key: Key("collection_" + _currentCollection.id),
          dense: true,
          title: Text(_currentCollection.name),
          onTap: () {
            print("click");
          },
          onLongPress: () {
            print("long press");
            value.changeSelection(
                widget.collectionLocation, !_currentCollection.selected);
          },
        );
      },
    );
  }
}
