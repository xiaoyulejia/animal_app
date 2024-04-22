import 'package:animal_app/config/palette.dart';
import 'package:animal_app/models/community_database.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/community_model/community_models.dart';

// ignore: must_be_immutable
class Stories extends StatelessWidget {
  late User currentUser;
  late List<Story> stories;

  Stories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        context.watch<CommunityDatabase>().findNowUser(),
        context.watch<CommunityDatabase>().fetchData(3),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          currentUser = snapshot.data![0] as User;
          stories = snapshot.data![1] as List<Story>;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              height: 200.0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.all(4.0),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 8.0,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: 1 + stories.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: _StoryCard(
                          isAddStory: true,
                          currentUser: currentUser,
                          userId: 1,
                        ),
                      );
                    }
                    final Story story = stories[index - 1];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: _StoryCard(userId: story.userId, story: story),
                    );
                  },
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class _StoryCard extends StatelessWidget {
  final bool isAddStory;
  final User? currentUser;
  final Story? story;
  final int userId;

  const _StoryCard({
    Key? key,
    this.isAddStory = false,
    this.currentUser,
    this.story,
    required this.userId, // 添加用户ID
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context
          .read<CommunityDatabase>()
          .findUserById(userId), // 使用findUserById获取用户信息
      builder: (context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final User user = snapshot.data!;

          final imageUrl = isAddStory ? currentUser?.imageUrl : story?.imageUrl;
          final userName = isAddStory ? '添加分享' : user.name;

          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: CachedNetworkImage(
                  imageUrl: imageUrl!,
                  height: double.infinity,
                  width: 110.0,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: double.infinity,
                width: 110.0,
                decoration: BoxDecoration(
                  gradient: Palette.storyGradient,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              Positioned(
                top: 8.0,
                left: 8.0,
                child: isAddStory
                    ? Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.add),
                          iconSize: 30.0,
                          color: Palette.facebookBlue,
                          onPressed: () => print('Add to Story'),
                          tooltip: 'Add to Story',
                        ),
                      )
                    : CircleAvatar(
                        backgroundImage:
                            CachedNetworkImageProvider(user.imageUrl),
                      ),
              ),
              Positioned(
                bottom: 8.0,
                left: 8.0,
                right: 8.0,
                child: Text(
                  userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
