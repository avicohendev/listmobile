import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:listmobile/common/widgets/listCard.dart';
import 'package:listmobile/common/widgets/overlaySpinner.dart';
import 'package:listmobile/models/toDoListCollection.dart';
import 'package:provider/provider.dart';

import '../../authentication/authentication.dart';
import '../../common/OverlayBuilder.dart';
import '../../common/widgets/collectionItem.dart';
import '../../providers/ListCollectionProvider.dart';

class CollectionAndLists extends StatefulWidget {
  final String collectionId;
  const CollectionAndLists({Key? key, required this.collectionId})
      : super(key: key);

  @override
  State<CollectionAndLists> createState() => _CollectionAndListsState();
}

class _CollectionAndListsState extends State<CollectionAndLists> {
  final _formKey = GlobalKey<FormState>();

  bool showTrashCan = false;
  final TextEditingController _listNameController = TextEditingController();
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
        child: const Icon(Icons.add),
        tooltip: "Add Collection",
        onPressed: () => _dialogBuilder(context),
      ),
      body: Center(
        child: FutureBuilder<void>(
          future: collectionProvider.fetchCollectionsByUser(getUser().email!),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: OverlaySpinner());
            } else {
              return Center(
                child: Consumer<TodoListCollectionProvider>(
                  builder: (context, value, child) {
                    return Center(
                        child: ListView.builder(
                            itemBuilder: (ctx, i) => Card(
                                  child: ListCard(
                                      collectionId: widget.collectionId,
                                      listLocation: i),
                                ),
                            itemCount: collectionProvider.collection
                                .firstWhere(
                                    (element) =>
                                        element.id == widget.collectionId,
                                    orElse: () =>
                                        ToDoListCollection.createEmpty())
                                .lists
                                .length));
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Create List Collection"),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _listNameController,
                    validator: (value) {
                      return value!.isNotEmpty ? null : "Enter List Name";
                    },
                    decoration: const InputDecoration(
                        hintText: "Please Enter List Name"),
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
                      .createListInCollection(
                          userEmail: getUser().email!,
                          listCollectionId: widget.collectionId,
                          name: _listNameController.text,
                          category: "");
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
