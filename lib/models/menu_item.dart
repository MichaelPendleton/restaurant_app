import 'package:restaurant_app/models/menu_item_type.dart';

class MenuItem {
  const MenuItem(
      {required this.id,
      required this.name,
      required this.type,
      required this.price,
      required this.isKids,
      required this.glutenFree,
      required this.imageURL});

  final String id;
  final String name;
  final MenuItemType type;
  final double price;
  final bool isKids;
  final bool glutenFree;
  final String imageURL;
}
