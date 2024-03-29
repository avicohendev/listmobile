import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:listmobile/authentication/authentication.dart';
import 'package:listmobile/common/OverlayBuilder.dart';
import 'package:listmobile/common/widgets/collectionItem.dart';
import 'package:listmobile/common/widgets/overlaySpinner.dart';
import 'package:listmobile/models/toDoListCollection.dart';
import 'package:listmobile/providers/ListCollectionProvider.dart';
import 'package:provider/provider.dart';

class MyList extends StatefulWidget {
  const MyList({Key? key}) : super(key: key);

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  final _formKey = GlobalKey<FormState>();
  bool showTrashCan = false;
  final TextEditingController _collectionNameController =
      TextEditingController();

  // void initState() {
  //   collectionProvider = Prov

  // }

  @override
  Widget build(BuildContext context) {
    TodoListCollectionProvider collectionProvider =
        Provider.of<TodoListCollectionProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        actionsIconTheme:
            const IconThemeData(size: 30.0, color: Colors.black, opacity: 10.0),
        title: const Text('My Collections'),
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
        tooltip: "Add Collection",
        onPressed: () => _dialogBuilder(context),
        child: const Icon(Icons.add),
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
                                  child: CollectionItem(collectionLocation: i),
                                ),
                            itemCount: collectionProvider.collection.length));
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
                    controller: _collectionNameController,
                    validator: (value) {
                      return value!.isNotEmpty ? null : "Enter collection Name";
                    },
                    decoration: const InputDecoration(
                        hintText: "Please Enter Collection Name"),
                  )
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
                      .createNewListCollection(
                          collectionName: _collectionNameController.text,
                          email: getUser().email!);
                  String name = getUser().email!;
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
