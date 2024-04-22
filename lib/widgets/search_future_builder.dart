import 'package:animal_app/models/animal_model.dart';
import 'package:animal_app/screens/animal_pages/animal_screen.dart';
import 'package:flutter/material.dart';

class SearchFutureBuilder extends StatelessWidget {
  final Future<Animal> future;
  const SearchFutureBuilder({super.key, required this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Animal>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final newdata = snapshot.data!;
          return DestinationScreen(animal: newdata);
        }
      },
    );
  }
}
