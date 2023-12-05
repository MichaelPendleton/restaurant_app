import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Food {
  Food({
    String? id,
    required this.name,
    required this.price,
    required this.image,
    required this.vegetarian,
    required this.glutenFree,
    required this.foodType,
    required this.forAdults,
    required this.forKids,
  }) : id = id ?? uuid.v4();

  final String id;
  final String name;
  final String price;
  final File image;
  final bool vegetarian;
  final bool glutenFree;
  final FoodTypes foodType;
  final bool forAdults;
  final bool forKids;
}

enum FoodTypes {
  entree,
  side,
  beverage,
}
