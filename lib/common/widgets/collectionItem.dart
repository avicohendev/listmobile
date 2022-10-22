import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:listmobile/models/toDoListCollection.dart';

class CollectionItem extends StatefulWidget {
  final ToDoListCollection collection;
  const CollectionItem({
    Key? key,
    required this.collection,
  }) : super(key: key);

  @override
  State<CollectionItem> createState() => _CollectionItemState();
}

class _CollectionItemState extends State<CollectionItem> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: isSelected ? const Icon(Icons.safety_check_rounded) : null,
      key: Key("collection_" + widget.collection.name),
      dense: true,
      title: Text(widget.collection.name),
      onTap: () {
        print("click");
      },
      onLongPress: () {
        print("long press");
        setState(() {
          isSelected = !isSelected;
        });
      },
    );
  }
}
