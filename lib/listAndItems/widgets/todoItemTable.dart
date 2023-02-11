import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:listmobile/models/listItem.dart';

class ToDoItemTable extends StatefulWidget {
  final List<ListItem> listItems;
  const ToDoItemTable({Key? key, required this.listItems}) : super(key: key);

  @override
  State<ToDoItemTable> createState() => _ToDoItemTableState();
}

class _ToDoItemTableState extends State<ToDoItemTable> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(label: Text("Todo item")),
          DataColumn(label: Text('Quantity'))
        ],
        rows: List<DataRow>.generate(
            widget.listItems.length,
            (index) => DataRow(cells: <DataCell>[
                  DataCell(Text(widget.listItems[index].name)),
                  DataCell(Text(widget.listItems[index].quantity.toString()))
                ])),
      ),
    );
  }
}
