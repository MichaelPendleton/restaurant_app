import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:restaurant_app/models/menu_item.dart';
import 'package:restaurant_app/widgets/new_menu_item.dart';

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
  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    loadMenuItems();
  }

  void loadMenuItems() async {
    final url = Uri.https(
        'csc322-restaurant-app-default-rtdb.firebaseio.com', 'menu.json');

    try {
      final response = await http.get(url);

      if (response.statusCode >= 400) {
        setState(() {
          _error = 'Failed to fetch data. Please try again later.';
        });
      }

      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final Map<String, dynamic> listData = json.decode(response.body);
      final List<MenuItem> loadedMenuItems = [];
      for (final menuItem in listData.entries) {
        loadedMenuItems.add(
          MenuItem(
            id: menuItem.key,
            name: menuItem.value['name'],
            price: menuItem.value['price'],
            type: menuItem.value['type'],
            isKids: menuItem.value['isKids'],
            glutenFree: menuItem.value['isGlutenFree'],
          ),
        );
      }
      setState(() {
        _menuItems = loadedMenuItems;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _error = 'Something went wrong! Please try again later.';
      });
    }
  }

  //Not yet implemented
  // void _removeMenuItem(MenuItem menuItem) async {
  //   final index = _menuItems.indexOf(menuItem);
  //   setState(() {
  //     _menuItems.remove(menuItem);
  //   });

  //   final url = Uri.https('csc322-shopping-default-rtdb.firebaseio.com',
  //       'shopping-list/${menuItem.id}.json');

  //   final response = await http.delete(url);

  //   if (response.statusCode >= 400) {
  //     // Optional: Show error message
  //     setState(() {
  //       _menuItems.insert(index, menuItem);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    }

    //WORK IN PROGRESS
    if (_menuItems.isNotEmpty) {
      content = Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _menuItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_menuItems[index].name),
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
          //Temporary Add Menu Item Button
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const NewMenuItem(),
                    ),
                  );
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: content);
  }
}
