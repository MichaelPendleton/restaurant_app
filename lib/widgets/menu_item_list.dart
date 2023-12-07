import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/types.dart';
import 'package:restaurant_app/main.dart';

import 'package:restaurant_app/models/menu_item.dart';
import 'package:restaurant_app/models/menu_item_type.dart';
import 'package:restaurant_app/widgets/new_menu_item.dart';

enum Selection { entree, side, beverage }

class MenuItemList extends StatefulWidget {
  const MenuItemList(
      {super.key, required this.selection, required this.isKidsFilter});

  final Selection selection;
  final bool isKidsFilter;

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
        final type = types.entries
            .firstWhere(
                (itemType) => itemType.value.title == menuItem.value['type'])
            .value;
        loadedMenuItems.add(
          MenuItem(
            id: menuItem.key,
            name: menuItem.value['name'],
            price: menuItem.value['price'],
            type: type,
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

  void _addItem() async {
    final newMenuItem = await Navigator.of(context).push<MenuItem>(
      MaterialPageRoute(
        builder: (context) => const NewMenuItem(),
      ),
    );

    if (newMenuItem == null) {
      return;
    }

    setState(() {
      _menuItems.add(newMenuItem);
    });
  }

  void _removeItem(MenuItem item) async {
    final index = _menuItems.indexOf(item);
    setState(() {
      _menuItems.remove(item);
    });

    final url = Uri.https('csc322-restaurant-app-default-rtdb.firebaseio.com',
        'menu/${item.id}.json');

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      // Optional: Show error message
      setState(() {
        _menuItems.insert(index, item);
      });
    }
  }

  // Helper function to convert type title string to Selection enum
  Selection _getTypeEnum(MenuItemType menuItemType) {
    if (menuItemType.title == types[MenuItemTypes.entree]!.title) {
      return Selection.entree;
    } else if (menuItemType.title == types[MenuItemTypes.side]!.title) {
      return Selection.side;
    } else if (menuItemType.title == types[MenuItemTypes.beverage]!.title) {
      return Selection.beverage;
    } else {
      // Default to entree if not recognized
      return Selection.entree;
    }
  }

  Widget _menuItemCards(
      BuildContext context, List filteredMenuItems, int index) {
    return Stack(children: [
      Card(
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: const Color.fromARGB(255, 163, 163, 211),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(filteredMenuItems[index].name,
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Price: \$${filteredMenuItems[index].price.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // const SizedBox(width: 20),
                // Visibility(
                //   visible: filteredMenuItems[index].glutenFree,
                //   child: SizedBox(
                //     width: 20,
                //     child: Image.asset(
                //       'assets/gluten_free.png',
                //       width: 350,
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                // Text(
                //   filteredMenuItems[index].glutenFree
                //       ? 'Gluten Free'
                //       : 'Contains Gluten',
                //   style:
                //       const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                // ),
                // const SizedBox(width: 20),
                // Text(
                //   _filteredMenuItems[index].isKids ? 'Kid ' : 'Adult',
                //   style: const TextStyle(
                //       fontSize: 20, fontWeight: FontWeight.bold),
                // ),
              ],
            ),
          ],
        ),
      ),
      Visibility(
        visible: filteredMenuItems[index].glutenFree,
        child: Container(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.95 - 32, top: 39),
          child: SizedBox(
            width: 35,
            child: Image.asset(
              'assets/gluten_free.png',
              width: 350,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));
    // Filter the menu items based on the selected category (Kids or Adults)
    final filteredMenuItems = _menuItems
        .where((item) =>
            (widget.isKidsFilter ? item.isKids : !item.isKids) &&
            (widget.selection == _getTypeEnum(item.type)))
        .toList();

    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    }

    //WORK IN PROGRESS
    if (filteredMenuItems.isNotEmpty) {
      content = Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: filteredMenuItems.length,
              itemBuilder: (context, index) => adminMode
                  ? Dismissible(
                      background: Container(
                        color: Colors.red.withOpacity(0.75),
                      ),
                      onDismissed: (direction) {
                        _removeItem(_menuItems[index]);
                      },
                      key: ValueKey(_menuItems[index].id),
                      child: _menuItemCards(context, filteredMenuItems, index),
                    )
                  : _menuItemCards(context, filteredMenuItems, index),
            ),
          ),
        ],
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Menu'),
          backgroundColor:
              adminMode ? const Color.fromARGB(255, 226, 87, 87) : null,
          actions: [
            // Opens form to add a new menu item to firebase
            Visibility(
              visible: adminMode,
              child: IconButton(
                onPressed: _addItem,
                icon: const Icon(Icons.add),
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: content);
  }
}
