import 'package:isar/isar.dart';

part 'story.g.dart';

@Collection()
class Story {
  final Id storyId;
  final int userId;
  final String imageUrl;

  Story({required this.storyId, required this.userId, required this.imageUrl});
}
