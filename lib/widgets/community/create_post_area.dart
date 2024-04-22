import 'package:animal_app/models/community_database.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePostContainer extends StatelessWidget {
  const CreatePostContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.watch<CommunityDatabase>().findNowUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final currentUser = snapshot.data!;
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 0),
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage:
                            CachedNetworkImageProvider(currentUser.imageUrl),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration.collapsed(
                            hintText: '今天有什么有趣的?',
                          ),
                        ),
                      )
                    ],
                  ),
                  const Divider(height: 10.0, thickness: 0.5),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
