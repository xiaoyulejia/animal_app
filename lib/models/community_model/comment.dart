import 'package:isar/isar.dart';

part 'comment.g.dart';

@Collection()
class Comment {
  final Id commentId;
  final int postId;
  final int userId;
  final String comment;
  final String comnentTime;
  final String? imageUrl;

  Comment({
    required this.commentId,
    required this.postId,
    required this.userId,
    required this.comment,
    required this.comnentTime,
    this.imageUrl,
  });
}
