import 'dart:io';

import 'package:restaurant_app/models/foodItem.dart';
import 'package:restaurant_app/providors/food_items.dart';
// import 'package:restaurant_app/screens/menu_screens/food_items.dart';
import 'package:restaurant_app/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddFoodItemScreen extends ConsumerStatefulWidget {
  const AddFoodItemScreen({super.key});

  @override
  ConsumerState<AddFoodItemScreen> createState() {
    return _AddFoodItemScreenState();
  }
}

class _AddFoodItemScreenState extends ConsumerState<AddFoodItemScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  var _isVegetarian = false;
  var _isGlutenFree = false;
  var _foodType = FoodTypes.entree;
  var _isForAdults = true;
  var _isForKids = false;
  File? _selectedImage;

  void _savePlace() {
    final enteredName = _nameController.text;
    final enteredPrice = _priceController.text;

    if (enteredName.isEmpty ||
        enteredName.trim().length <= 1 ||
        enteredName.trim().length > 50) {
      return; // 'Must be between 1 and 50 characters.'
    }

    if (enteredPrice.isEmpty || _selectedImage == null) {
      return;
    }

    ref.read(foodItemsProvider.notifier).addFoodItem(
          enteredName,
          enteredPrice,
          _selectedImage!,
          _isVegetarian,
          _isGlutenFree,
          _foodType,
          _isForAdults,
          _isForKids,
        );

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Food Item'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Name'),
              controller: _nameController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            // const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Price'),
                    controller: _priceController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                    child:
                        // DropdownButtonFormField(
                        //       value: _foodType,
                        //       items: [
                        //         for (final menuItemType in FoodTypes.entree)
                        //           DropdownMenuItem(
                        //             value: menuItemType.value,
                        //             child: Text(menuItemType.value.title),
                        //           ),
                        //       ],
                        //       onChanged: (value) {
                        //         setState(() {
                        //           _foodType = value! as TextEditingController;
                        //         });
                        //       },
                        //     ),
                        // ),
                        Column(
                  children: [
                    CheckboxListTile(
                      title: Text('Vegetarian'),
                      value: _isVegetarian,
                      onChanged: (newValue) {
                        setState(
                          () {
                            _isVegetarian = !_isVegetarian;
                          },
                        );
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Gluten Free'),
                      value: _isGlutenFree,
                      onChanged: (newValue) {
                        setState(
                          () {
                            _isGlutenFree = !_isGlutenFree;
                          },
                        );
                      },
                    ),
                  ],
                ))
              ],
            ),

            const SizedBox(height: 10),
            ImageInput(
              onPickImage: (image) {
                _selectedImage = image;
              },
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _savePlace,
              icon: const Icon(Icons.add),
              label: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
