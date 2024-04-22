import 'package:animal_app/models/animal_model.dart';
import 'package:animal_app/models/favorite_database.dart';
import 'package:animal_app/widgets/animal_carousel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyFutureBuilder extends StatelessWidget {
  final String sortName;

  const MyFutureBuilder({Key? key, required this.sortName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Animal>>(
      future: context.watch<FavoriteData>().findSortData(sortName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final newdata = snapshot.data!;
          print("当前分类长度${newdata.length}");
          return DestinationCarousel(animals: newdata);
        }
      },
    );
  }
}
