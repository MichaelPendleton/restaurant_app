import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import 'package:restaurant_app/models/foodItem.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
    },
    version: 2,
  );
  return db;
}

class FoodItemsNotifier extends StateNotifier<List<Food>> {
  FoodItemsNotifier() : super(const []);

  Future<void> loadFoodItems() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');
    final places = data
        .map(
          (row) => Food(
            id: row['id'] as String,
            name: row['name'] as String,
            price: row['price'] as String,
            image: File(row['image'] as String),
            vegetarian: row['vegetarian'] as bool,
            glutenFree: row['glutenFree'] as bool,
            foodType: row['foodType'] as FoodTypes,
            forAdults: row['forAdults'] as bool,
            forKids: row['forKids'] as bool,
          ),
        )
        .toList();
    state = places;
  }

  void addFoodItem(String name, String price, File image, bool vegetarian,
      bool glutenFree, FoodTypes foodType, bool forAdults, bool forKids) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory(); // cache
    final filename = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$filename');

    final newPlace = Food(
        name: name,
        price: price,
        image: copiedImage,
        vegetarian: vegetarian,
        glutenFree: glutenFree,
        foodType: foodType,
        forAdults: forAdults,
        forKids: forKids);
    final db = await _getDatabase();
    db.insert('user_places', {
      'id': newPlace.id,
      'name': newPlace.name,
      'price': newPlace.price,
      'image': newPlace.image.path,
      'vegetarian': newPlace.vegetarian,
      'glutenFree': newPlace.glutenFree,
      'foodType': newPlace.foodType,
      'forAdults': newPlace.forAdults,
      'forKids': newPlace.forKids,
    });

    state = [newPlace, ...state];
  }
}

final foodItemsProvider = StateNotifierProvider<FoodItemsNotifier, List<Food>>(
  (ref) => FoodItemsNotifier(),
);
