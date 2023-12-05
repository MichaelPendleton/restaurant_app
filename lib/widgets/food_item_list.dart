import 'package:restaurant_app/models/foodItem.dart';
import 'package:restaurant_app/screens/menu_screens/food_item_details.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.foodItems});

  final List<Food> foodItems;

  @override
  Widget build(BuildContext context) {
    if (foodItems.isEmpty) {
      return Center(
        child: Text(
          'No places added yet',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      );
    }

    return ListView.builder(
      itemCount: foodItems.length,
      itemBuilder: (ctx, index) => Card(
        margin: const EdgeInsets.all(8),
        color: Theme.of(context)
            .primaryColor, // Change later based on decided theme
        child: Stack(
          children: [
            Ink.image(
              image: FileImage(
                foodItems[index].image,
              ),
              height: 160,
              fit: BoxFit.cover,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 45),
                Text(foodItems[index].name,
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 5),
                    Text(
                      'Price: \$${foodItems[index].price}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Visibility(
                      visible: foodItems[index].vegetarian,
                      child: const Text(
                        'V',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Visibility(
                      visible: foodItems[index].glutenFree,
                      child: const Text(
                        'GF',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 5),
                    // Text(
                    //   foodItems[index].glutenFree
                    //       ? 'Gluten Free'
                    //       : 'Contains Gluten',
                    //   style: const TextStyle(
                    //       fontSize: 20, fontWeight: FontWeight.bold),
                    // ),
                    // Image(image: foodItems[index].image),
                    // const SizedBox(width: 20),
                    // Text(
                    //   _filteredMenuItems[index].isKids ? 'Kid ' : 'Adult',
                    //   style: const TextStyle(
                    //       fontSize: 20, fontWeight: FontWeight.bold),
                    // ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
