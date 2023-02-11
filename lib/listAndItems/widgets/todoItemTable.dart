import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:listmobile/listAndItems/models/rowItem.dart';
import 'package:listmobile/models/listItem.dart';
import 'package:listmobile/common/mappedIndex.dart';

class ToDoItemTable extends StatefulWidget {
  final List<ListItem> listItems;
  const ToDoItemTable({Key? key, required this.listItems}) : super(key: key);

  @override
  State<ToDoItemTable> createState() => _ToDoItemTableState();
}

class _ToDoItemTableState extends State<ToDoItemTable> {
  late List<bool> selected;
  late bool shouldShowSelection = false;
  late List<RowItem> rows;

  @override
  void initState() {
    selected = List.generate(widget.listItems.length, (index) => false,
        growable: true);
    rows = List.generate(widget.listItems.length,
        (index) => RowItem.fromListItem(widget.listItems[index]));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    selected = List.generate(widget.listItems.length, (index) => false,
        growable: true);
    rows = List.generate(widget.listItems.length,
        (index) => RowItem.fromListItem(widget.listItems[index]));
  }

  @override
  void didUpdateWidget(ToDoItemTable oldWidget) {
    super.didUpdateWidget(oldWidget);

    rows = List.generate(widget.listItems.length,
        (index) => RowItem.fromListItem(widget.listItems[index]));
    shouldShowSelection = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(24),
        child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(label: Text("Todo item")),
                    DataColumn(label: Text('Quantity'))
                  ],
                  rows: rows
                      .mapIndexed((item, index) => DataRow(
                            cells: <DataCell>[
                              DataCell(Text(item.name)),
                              DataCell(Text(item.quantity.toString()))
                            ],
                            selected: item.selected,
                            onSelectChanged: shouldShowSelection
                                ? (value) {
                                    setState(() {
                                      item.selected = !item.selected;
                                      bool noItemSelected = rows
                                          .where((rowItem) =>
                                              rowItem.selected == true)
                                          .isEmpty;
                                      if (noItemSelected) {
                                        shouldShowSelection = false;
                                      }
                                    });
                                  }
                                : null,
                            onLongPress: () {
                              if (!shouldShowSelection) {
                                setState(() {
                                  shouldShowSelection = true;
                                  if (!item.selected) {
                                    item.selected = true;
                                  }
                                });
                              }
                            },
                          ))
                      .toList()),
            )));
  }
}
