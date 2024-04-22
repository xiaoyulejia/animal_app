import 'package:animal_app/config/palette.dart';
import 'package:animal_app/models/community_database.dart';
import 'package:animal_app/models/community_model/community_models.dart';
import 'package:animal_app/widgets/community/post_area.dart';
import 'package:animal_app/widgets/community/story_area.dart';
import 'package:animal_app/widgets/community/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CommunityPage extends StatefulWidget {
  CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: context.watch<CommunityDatabase>().fetchData(2),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final data = snapshot.data!;
            return CustomScrollView(
              controller: _trackingScrollController,
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  title: Text(
                    '蔚生·社区',
                    style: const TextStyle(
                      color: Palette.mainBlue,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1.2,
                    ),
                  ),
                  centerTitle: false,
                  floating: true,
                ),
                SliverToBoxAdapter(
                  child: CreatePostContainer(),
                ),
                // 横向分享
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                  sliver: SliverToBoxAdapter(child: Stories()),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final int reversedIndex = data.length - 1 - index;
                      final Post post = data[reversedIndex];
                      return PostContainer(
                        post: post,
                      );
                    },
                    childCount: data.length,
                  ),
                ),
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).indicatorColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String userInput = '';
              String imageLink = '';

              return AlertDialog(
                title: Text('发点什么?'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      onChanged: (value) {
                        userInput = value;
                      },
                      decoration: InputDecoration(
                        hintText: '输入内容',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      onChanged: (value) {
                        imageLink = value;
                      },
                      decoration: InputDecoration(
                        hintText: '输入图片链接',
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(
                          {'userInput': userInput, 'imageLink': imageLink});
                    },
                    child: Text('确定'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('取消'),
                  ),
                ],
              );
            },
          ).then((result) async {
            if (result != null) {
              int _postNum =
                  await context.read<CommunityDatabase>().getPostNum();
              String userInput = result['userInput'];
              String imageLink = result['imageLink'];
              Post post = Post(
                  postId: _postNum + 1,
                  userId: 1,
                  caption: userInput,
                  timeAgo: "刚刚",
                  imageUrl: imageLink,
                  likes: 0,
                  comments: 0,
                  shares: 0);
              await context.read<CommunityDatabase>().addPost(post);
              setState(() {});
            }
          });
        },
        child: Icon(FontAwesomeIcons.plus),
      ),
    );
  }
}
