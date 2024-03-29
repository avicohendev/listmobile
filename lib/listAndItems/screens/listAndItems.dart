import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:listmobile/common/widgets/listCard.dart';
import 'package:listmobile/common/widgets/overlaySpinner.dart';
import 'package:listmobile/listAndItems/widgets/todoItemTable.dart';
import 'package:listmobile/models/listItem.dart';
import 'package:listmobile/models/toDoList.dart';
import 'package:listmobile/models/toDoListCollection.dart';
import 'package:provider/provider.dart';

import '../../authentication/authentication.dart';
import '../../common/OverlayBuilder.dart';
import '../../providers/ListCollectionProvider.dart';

class ListAndItems extends StatefulWidget {
  final String collectionId;
  final String listName;
  const ListAndItems(
      {Key? key, required this.collectionId, required this.listName})
      : super(key: key);

  @override
  State<ListAndItems> createState() => _ListAndItemsState();
}

class _ListAndItemsState extends State<ListAndItems> {
  final _formKey = GlobalKey<FormState>();

  bool showTrashCan = false;
  final TextEditingController _listItemNameController = TextEditingController();
  final TextEditingController _listItemQuantityController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    TodoListCollectionProvider collectionProvider =
        Provider.of<TodoListCollectionProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        actionsIconTheme:
            const IconThemeData(size: 30.0, color: Colors.black, opacity: 10.0),
        title: const Text('My Lists'),
        actions: [
          Consumer<TodoListCollectionProvider>(
            builder: (context, value, child) => value.showCheckBoxes
                ? IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _onDeleteLists(context))
                : Container(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add List",
        onPressed: () => _dialogBuilder(context),
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<void>(
        future: collectionProvider.fetchCollectionsByUser(getUser().email!),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: OverlaySpinner());
          } else {
            return Consumer<TodoListCollectionProvider>(
              builder: (context, value, child) {
                List<ListItem> listItems = value.collection
                    .firstWhere((element) => element.id == widget.collectionId)
                    .lists
                    .firstWhere((element) => element.name == widget.listName,
                        orElse: () => ToDoList.createEmpty())
                    .listItems;
                return ToDoItemTable(
                  key: const Key("itemTable"),
                  listItems: listItems,
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Create List Item"),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _listItemNameController,
                    validator: (value) {
                      return value!.isNotEmpty ? null : "Enter List Name";
                    },
                    decoration: const InputDecoration(
                        hintText: "Please Enter Item Name"),
                  ),
                  TextFormField(
                    controller: _listItemQuantityController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      return value!.isNotEmpty ? null : "Enter Quantity";
                    },
                    decoration: const InputDecoration(
                        hintText: "Please Enter Item Quantity"),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              InkWell(
                child: const Text('Create'),
                onTap: () async {
                  OverlayBuilder.showOverlay(context);
                  await Provider.of<TodoListCollectionProvider>(context,
                          listen: false)
                      .addItemToList(
                          userEmail: getUser().email!,
                          listCollectionId: widget.collectionId,
                          listName: widget.listName,
                          itemName: _listItemNameController.text,
                          itemQuantity:
                              int.parse(_listItemQuantityController.text));
                  OverlayBuilder.hideOverlay();
                  Navigator.of(context).pop();
                },
              ),
              InkWell(
                child: const Text('Discard'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<void> _onDeleteLists(BuildContext context) async {
    String userEmail = getUser().email!;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Are you sure you want to delete?"),
            actions: <Widget>[
              InkWell(
                child: const Text('Delete'),
                onTap: () async {
                  OverlayBuilder.showOverlay(context);
                  await Provider.of<TodoListCollectionProvider>(context,
                          listen: false)
                      .setDeleted(userEmail);
                  OverlayBuilder.hideOverlay();
                  Navigator.of(context).pop();
                },
              ),
              InkWell(
                child: const Text('Discard'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
