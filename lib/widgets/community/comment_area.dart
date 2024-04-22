import 'package:animal_app/models/community_model/comment.dart';
import 'package:animal_app/models/community_model/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CommentArea extends StatelessWidget {
  final int postId;
  final User user;
  final Comment comment;

  CommentArea(
      {super.key,
      required this.postId,
      required this.user,
      required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
        padding: EdgeInsets.all(8.0),
        height: 80,
        child: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: CachedNetworkImageProvider(user.imageUrl),
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${user.name}:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 3),
                Text(comment.comment)
              ],
            ),
            Spacer(),
            Text("${comment.comnentTime}前评论"),
          ],
        ),
      ),
    );
  }
}
