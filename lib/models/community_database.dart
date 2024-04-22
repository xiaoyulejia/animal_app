import 'package:animal_app/models/community_model/community_models.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class CommunityDatabase extends ChangeNotifier {
  static late Isar isarUser;
  static late Isar isarPost;
  static late Isar isarStory;
  static late Isar isarComment;

  // 初始化isar数据库
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isarUser = await Isar.open([UserSchema], directory: dir.path, name: "user");
    isarPost = await Isar.open([PostSchema], directory: dir.path, name: "post");
    isarStory =
        await Isar.open([StorySchema], directory: dir.path, name: "story");
    isarComment =
        await Isar.open([CommentSchema], directory: dir.path, name: "comment");
  }

  // 默认数据写入
  static Future<void> addDefaultData(List<User> data1, List<Post> data2,
      List<Story> data3, List<Comment> data4) async {
    await isarUser.writeTxn(() => isarUser.users.putAll(data1));
    await isarPost.writeTxn(() => isarPost.posts.putAll(data2));
    await isarStory.writeTxn(() => isarStory.storys.putAll(data3));
    await isarComment.writeTxn(() => isarComment.comments.putAll(data4));
    print("社区添加摸扔数据成功");
  }

  // 删除全部数据
  static Future<void> deleteAllData() async {
    await isarUser.writeTxn(() => isarUser.users.where().deleteAll());
    await isarPost.writeTxn(() => isarPost.posts.where().deleteAll());
    await isarStory.writeTxn(() => isarStory.storys.where().deleteAll());
    await isarComment.writeTxn(() => isarComment.comments.where().deleteAll());
  }

  // 读取数据
  Future<List> fetchData(int i) async {
    switch (i) {
      case 1:
        {
          List<User> fetchedUser = await isarUser.users.where().findAll();
          return fetchedUser;
        }
      case 2:
        {
          List<Post> fetchedPost = await isarPost.posts.where().findAll();
          return fetchedPost;
        }
      case 3:
        {
          List<Story> fetchedStory = await isarStory.storys.where().findAll();
          return fetchedStory;
        }
      case 4:
        {
          List<Comment> fetchedComment =
              await isarComment.comments.where().findAll();
          return fetchedComment;
        }
      default:
        return [];
    }
  }

  // 数据库操作
  // ----------  添加数据  ---------
  Future<void> addUser(User user) async {
    await isarUser.writeTxn(() => isarUser.users.put(user));
    fetchData(1);
  }

  Future<void> addPost(Post post) async {
    await isarPost.writeTxn(() => isarPost.posts.put(post));
    fetchData(2);
  }

  Future<void> addStory(Story story) async {
    await isarStory.writeTxn(() => isarStory.storys.put(story));
    fetchData(3);
  }

  Future<void> addComment(Comment comment) async {
    await isarComment.writeTxn(() => isarComment.comments.put(comment));
    fetchData(4);
  }

  // ----------  查询操作  ----------
  // 返回当前用户
  Future<User> findNowUser() async {
    final query = isarUser.users.where().filter().userIdEqualTo(1);
    final fetched = await query.findAll();
    return fetched[0];
  }

  // 根据id返回用户
  Future<User> findUserById(int i) async {
    final query = isarUser.users.where().filter().userIdEqualTo(i);
    final fetched = await query.findAll();
    return fetched[0];
  }

  // 根据id返回评论
  Future<Comment> findCommentById(int i) async {
    final query = isarComment.comments.where().filter().userIdEqualTo(i);
    final fetched = await query.findAll();
    return fetched[0];
  }

  // 返回当前post有多少评论
  Future<int> getCommentNum(int postId) async {
    final query = isarComment.comments.where().filter().postIdEqualTo(postId);
    final fetched = await query.findAll();
    return fetched.length;
  }

  // 返回当前有多少post
  Future<int> getPostNum() async {
    final fetched = await isarPost.posts.where().findAll();
    return fetched.length;
  }

  // 返回当前post评论的用户列表
  Future<List<User>> getCommentUserList(int postId) async {
    final query = isarComment.comments.where().filter().postIdEqualTo(postId);
    final fetched = await query.findAll();
    List<User> userList = [];

    for (var i = 0; i < fetched.length; i++) {
      userList.add(await findUserById(fetched[i].userId));
    }

    return userList;
  }

  // 返回当前post评论的列表
  Future<List<Comment>> getCommentList(int postId) async {
    final query = isarComment.comments.where().filter().postIdEqualTo(postId);
    final fetched = await query.findAll();
    return fetched;
  }

  // ---------  更新操作  -----------
  // 点赞实现
  Future<void> updateLikes(Post post) async {
    // 获取要更新的帖子对象
    final query = isarPost.posts.where().filter().postIdEqualTo(post.postId);
    final fetched = await query.findAll();
    Post newPost = Post(
        postId: post.postId,
        userId: post.userId,
        caption: post.caption,
        timeAgo: post.timeAgo,
        imageUrl: post.imageUrl,
        likes: post.likes + 1,
        comments: post.comments,
        shares: post.shares);

    if (fetched.isNotEmpty) {
      await isarPost.writeTxn(() => isarPost.posts.put(newPost));
    }
  }
}
