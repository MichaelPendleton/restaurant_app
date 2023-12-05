import 'package:flutter/material.dart';

import 'package:restaurant_app/models/foodItem.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key, required this.food});

  final Food food;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(food.name),
      ),
      body: Stack(
        children: [
          Image.file(
            food.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ],
      ),
    );
  }
}
