import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ListAndItems extends StatefulWidget {
  const ListAndItems({Key? key}) : super(key: key);

  @override
  State<ListAndItems> createState() => _ListAndItemsState();
}

class _ListAndItemsState extends State<ListAndItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(),
      ),
      body: Container(),
      floatingActionButton: Container(),
    );
  }
}
