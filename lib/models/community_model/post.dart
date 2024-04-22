import 'package:isar/isar.dart';

part 'post.g.dart';

@Collection()
class Post {
  final Id postId;
  final int userId;
  final String caption;
  final String timeAgo;
  final String imageUrl;
  int likes;
  final int comments;
  final int shares;
  bool isLike;
  bool isComment;

  Post({
    required this.postId,
    required this.userId,
    required this.caption,
    required this.timeAgo,
    required this.imageUrl,
    required this.likes,
    required this.comments,
    required this.shares,
    this.isLike = false,
    this.isComment = false,
  });
}
