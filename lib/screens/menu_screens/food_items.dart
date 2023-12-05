import 'package:restaurant_app/providors/food_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/screens/menu_screens/add_food_item.dart';
import 'package:restaurant_app/widgets/food_item_list.dart';

class FoodItemsScreen extends ConsumerStatefulWidget {
  const FoodItemsScreen({super.key});

  @override
  ConsumerState<FoodItemsScreen> createState() {
    return _FoodItemsScreenState();
  }
}

class _FoodItemsScreenState extends ConsumerState<FoodItemsScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(foodItemsProvider.notifier).loadFoodItems();
  }

  @override
  Widget build(BuildContext context) {
    final foodItems = ref.watch(foodItemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AddFoodItemScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _placesFuture,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : PlacesList(
                      foodItems: foodItems,
                    ),
        ),
      ),
    );
  }
}
