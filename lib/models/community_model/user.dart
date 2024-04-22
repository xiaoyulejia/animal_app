import 'package:isar/isar.dart';

part 'user.g.dart';

@Collection()
class User {
  final Id userId;
  final String name;
  final String imageUrl;

  User({required this.userId, required this.name, required this.imageUrl});
}
