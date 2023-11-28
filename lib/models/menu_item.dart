import 'package:restaurant_app/models/menu_item_type.dart';

class MenuItem {
  const MenuItem({
    required this.id,
    required this.name,
    required this.price,
    required this.type,
    required this.isKids,
    required this.glutenFree,
  });

  final String id;
  final String name;
  final double price;
  final MenuItemType type;
  final bool isKids;
  final bool glutenFree;
}
