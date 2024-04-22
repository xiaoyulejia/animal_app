import 'package:animal_app/config/palette.dart';
import 'package:animal_app/models/community_database.dart';
import 'package:animal_app/models/community_model/post.dart';
import 'package:animal_app/screens/community_pages/post_detail.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class PostContainer extends StatelessWidget {
  final Post post;

  const PostContainer({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PostDetail(
                    post: post,
                  ))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          margin: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 0.0,
          ),
          elevation: 0.0,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _PostHeader(post: post),
                      const SizedBox(height: 4.0),
                      Text(post.caption),
                      // ignore: unnecessary_null_comparison
                      post.imageUrl != null
                          ? const SizedBox.shrink()
                          : const SizedBox(height: 6.0),
                    ],
                  ),
                ),
                // ignore: unnecessary_null_comparison
                post.imageUrl != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Hero(
                            tag: post.postId,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: CachedNetworkImage(
                                    imageUrl: post.imageUrl)),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: _PostStats(post: post),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final Post post;

  const _PostHeader({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.watch<CommunityDatabase>().findUserById(post.userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final user = snapshot.data!;

          return Row(
            children: [
              CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(user.imageUrl)),
              const SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${post.timeAgo} • ',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12.0,
                          ),
                        ),
                        Icon(
                          Icons.public,
                          color: Colors.grey[600],
                          size: 12.0,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_horiz),
                onPressed: () => print('More'),
              ),
            ],
          );
        }
      },
    );
  }
}

// ignore: must_be_immutable
class _PostStats extends StatefulWidget {
  late Post post;

  _PostStats({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<_PostStats> createState() => _PostStatsState();
}

class _PostStatsState extends State<_PostStats> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Palette.facebookBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.thumb_up,
                size: 10.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 4.0),
            Expanded(
              child: Text(
                '${widget.post.likes}',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
            Text(
              '${widget.post.comments} 评论',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              '${widget.post.shares} 分享',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            )
          ],
        ),
        const Divider(),
        Row(
          children: [
            _PostButton(
              icon: Icon(
                widget.post.isLike ? MdiIcons.thumbUp : MdiIcons.thumbUpOutline,
                color: Colors.grey[600],
                size: 20.0,
              ),
              label: '点赞',
              onTap: () async {
                if (!widget.post.isLike) {
                  await context
                      .read<CommunityDatabase>()
                      .updateLikes(widget.post);
                  setState(() {
                    widget.post.isLike = true;
                    widget.post.likes += 1;
                  });
                } else {
                  print("你已经点过赞了!");
                }
              },
            ),
            _PostButton(
              icon: Icon(
                MdiIcons.commentOutline,
                color: Colors.grey[600],
                size: 20.0,
              ),
              label: '评论',
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PostDetail(
                            post: widget.post,
                          ))),
            ),
            _PostButton(
              icon: Icon(
                MdiIcons.shareOutline,
                color: Colors.grey[600],
                size: 25.0,
              ),
              label: '分享',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    String userInput = '';

                    return AlertDialog(
                      title: Text('转发'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            onChanged: (value) {
                              userInput = value;
                            },
                            decoration: InputDecoration(
                              hintText: '评论',
                            ),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop({
                              'userInput': userInput,
                            });
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
                    String _postUserName = (await context
                            .read<CommunityDatabase>()
                            .findUserById(widget.post.userId))
                        .name;
                    String userInput = result['userInput'];
                    Post post = Post(
                        postId: _postNum + 1,
                        userId: 1,
                        caption: "转发自 ${_postUserName} \n${userInput}",
                        timeAgo: "刚刚",
                        imageUrl: widget.post.imageUrl,
                        likes: 0,
                        comments: 0,
                        shares: 0);
                    await context.read<CommunityDatabase>().addPost(post);
                    setState(() {});
                  }
                });
              },
            )
          ],
        ),
      ],
    );
  }
}

class _PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final VoidCallback? onTap;

  const _PostButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 4.0),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
