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

  final TextEditingController _collectionNameController =
      TextEditingController();
  Future<void> _refreshCollections(BuildContext context) async {
    String userEmail = getUser().email!;
    return await Provider.of<TodoListCollectionProvider>(context, listen: false)
        .fetchCollectionsByUser(userEmail);
  }

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
        title: const Text('My Lists'),
        actions: [
          collectionProvider.showCheckBoxes
              ? const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Icon(Icons.ac_unit),
                )
              : Container()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        tooltip: "Add List",
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
}
