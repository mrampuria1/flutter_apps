import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String recipeName;
  final String recipeIngredient;
  final String recipeInstruction;

  DetailsScreen({required this.recipeName, required this.recipeIngredient, required this.recipeInstruction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Recipe Name: $recipeName',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Ingredients:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              recipeIngredient,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Instructions:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              recipeInstruction,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
