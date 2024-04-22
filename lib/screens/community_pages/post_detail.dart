import 'package:animal_app/models/community_database.dart';
import 'package:animal_app/models/community_model/community_models.dart';
import 'package:animal_app/widgets/community/comment_area.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PostDetail extends StatefulWidget {
  final Post post;
  const PostDetail({super.key, required this.post});

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Hero(
                  tag: widget.post.postId,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: CachedNetworkImage(
                        imageUrl: widget.post.imageUrl,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: Colors.black,
                      onPressed: () => Navigator.pop(context),
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.search),
                          iconSize: 30.0,
                          color: Colors.black,
                          onPressed: () => Navigator.pop(context),
                        ),
                        IconButton(
                          icon: Icon(Icons.sort),
                          iconSize: 25.0,
                          color: Colors.black,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 20.0,
                bottom: 20.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${widget.post.likes}点赞",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.share,
                          size: 15.0,
                          color: Colors.white70,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          "${widget.post.shares}分享",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: CommentBuilder(postId: widget.post.postId),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).indicatorColor,
        onPressed: () async {
          final usercomment = await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              String userInput = '';

              return AlertDialog(
                title: Text('添加评论'),
                content: TextField(
                  onChanged: (value) {
                    userInput = value;
                  },
                  decoration: InputDecoration(
                    hintText: '输入您的评论',
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(userInput);
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
          );

          if (usercomment != null && usercomment.isNotEmpty) {
            int _commentNum = await context
                .read<CommunityDatabase>()
                .getCommentNum(widget.post.postId);
            Comment comment = Comment(
              commentId: _commentNum + 1,
              postId: widget.post.postId,
              userId: 1,
              comment: usercomment,
              comnentTime: "刚刚",
            );
            await context.read<CommunityDatabase>().addComment(comment);
            setState(() {});
          }
        },
        child: Icon(FontAwesomeIcons.comment),
      ),
    );
  }
}

class CommentBuilder extends StatelessWidget {
  final int postId;
  const CommentBuilder({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        context.watch<CommunityDatabase>().getCommentNum(postId),
        context.watch<CommunityDatabase>().getCommentUserList(postId),
        context.watch<CommunityDatabase>().getCommentList(postId),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final commentNum = snapshot.data![0] as int;
          final users = snapshot.data![1] as List<User>;
          final comments = snapshot.data![2] as List<Comment>;

          if (commentNum == 0) {
            return Center(
              child: Text("还没有评论哦! 你来做第一个?"),
            );
          } else {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: ListView.builder(
                itemCount: commentNum,
                itemBuilder: (BuildContext context, int index) {
                  User user = users[index];
                  Comment comment = comments[index];

                  return CommentArea(
                      postId: postId, user: user, comment: comment);
                },
              ),
            );
          }
        }
      },
    );
  }
}
