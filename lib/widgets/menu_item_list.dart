import 'package:flutter/material.dart';
import 'package:restaurant_app/models/menu_item.dart';

enum Selection { entree, side, beverage }

class MenuItemList extends StatefulWidget {
  const MenuItemList(
      {super.key, required this.selection, required this.isKids});

  final Selection selection;
  final bool isKids;

  @override
  State<MenuItemList> createState() => _MenuItemListState();
}

class _MenuItemListState extends State<MenuItemList> {
  List<MenuItem> _menuItems = [];

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    //WORK IN PROGRESS
    if (_menuItems.isNotEmpty) {
      content = Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _menuItems.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              },
            ),
          ),
        ],
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Menu'),
        ),
        body: content);
  }
}
