import 'package:listmobile/models/listItem.dart';

class RowItem {
  String name;
  int quantity;
  bool lineCross;
  bool selected;

  RowItem(
      {required this.name,
      required this.quantity,
      required this.lineCross,
      required this.selected});

  factory RowItem.fromListItem(ListItem item) {
    return RowItem(
        name: item.name,
        quantity: item.quantity,
        lineCross: item.lineCross,
        selected: false);
  }
}
