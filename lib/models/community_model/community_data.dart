import 'package:animal_app/models/community_model/community_models.dart';

final List<User> userData = [
  User(
      userId: 1,
      name: "小娱乐家",
      imageUrl:
          "https://i0.hdslb.com/bfs/new_dyn/3d8c6da0b5e40372897d1852876d3626106307213.png"),
  User(
      userId: 2,
      name: "小九",
      imageUrl:
          "https://i0.hdslb.com/bfs/new_dyn/47dcd977c18696a27334a7ce34c19fde475578564.jpg"),
  User(
      userId: 3,
      name: "耀",
      imageUrl:
          "http://i0.hdslb.com/bfs/new_dyn/5f595d50112f972b9b0400193ba4b034416571322.jpg"),
  User(
      userId: 4,
      name: "张三",
      imageUrl:
          "https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1331&q=80"),
  User(
      userId: 5,
      name: "李四",
      imageUrl:
          "https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80"),
  User(
      userId: 6,
      name: "王五",
      imageUrl:
          "https://images.unsplash.com/photo-1521119989659-a83eee488004?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=664&q=80"),
];

final List<Post> postData = [
  Post(
      postId: 5,
      userId: 1,
      caption: '这是台湾山鹧鸪, 刚在维基百科上看见的!',
      timeAgo: '8分钟前',
      imageUrl:
          'https://cdn.hxsjcbs.com/Uploads/Picture/nature_pics/37/59/0027/1060eafc9ac05071077fe6354c23c72b.jpg',
      likes: 233,
      comments: 0,
      shares: 233),
  Post(
      postId: 4,
      userId: 2,
      caption: '看我家猫猫, 盯~',
      timeAgo: '8分钟前',
      imageUrl:
          'https://i0.hdslb.com/bfs/new_dyn/a004b3cda18220066a01ca5a7b3c53a4106307213.jpg',
      likes: 233,
      comments: 0,
      shares: 233),
  Post(
      postId: 3,
      userId: 3,
      caption: '看看我家的柴犬!',
      timeAgo: '23分钟前',
      imageUrl:
          'https://images.unsplash.com/photo-1575535468632-345892291673?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
      likes: 233,
      comments: 0,
      shares: 233),
  Post(
      postId: 2,
      userId: 2,
      caption: '邻居家的小狗',
      timeAgo: '13小时前',
      imageUrl:
          'https://images.unsplash.com/photo-1578133671540-edad0b3d689e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1351&q=80',
      likes: 233,
      comments: 0,
      shares: 233),
  Post(
      postId: 1,
      userId: 4,
      caption: '看看我今天出去玩看见的小狗!',
      timeAgo: '2天前',
      imageUrl: 'https://images.unsplash.com/photo-1525253086316-d0c936c814f8',
      likes: 233,
      comments: 0,
      shares: 233),
];

final List<Story> storyData = [
  Story(
      storyId: 1,
      userId: 2,
      imageUrl:
          "https://i0.hdslb.com/bfs/new_dyn/94a669e21da1598f70b76264d76a85d5106307213.jpg"),
  Story(
      storyId: 2,
      userId: 3,
      imageUrl:
          "https://cdn.hxsjcbs.com/Uploads/Picture/nature_pics/43/60/0097/25c5f3629b139df6fc346504cfd86fe6.jpg"),
  Story(
      storyId: 3,
      userId: 4,
      imageUrl:
          "https://cdn.hxsjcbs.com/Uploads/Picture/nature_pics/43/60/0079/6b785fda170a68ac6826993b4cf73fd2.jpg"),
  Story(
      storyId: 4,
      userId: 5,
      imageUrl:
          "https://cdn.hxsjcbs.com/Uploads/Picture/nature_pics/37/59/0033/c89f873695bffa5dd69ad03e5a63bfae.jpg"),
];

final List<Comment> commentData = [
  Comment(
      commentId: 1, postId: 4, userId: 1, comment: "你家猫猫可爱", comnentTime: "刚刚"),
  Comment(
      commentId: 2, postId: 4, userId: 3, comment: "非常喜欢", comnentTime: "1m"),
  Comment(
      commentId: 3, postId: 2, userId: 1, comment: "非常喜欢", comnentTime: "18h"),
  Comment(
      commentId: 4,
      postId: 5,
      userId: 2,
      comment: "第一次看见这个诶!",
      comnentTime: "2m"),
  Comment(
      commentId: 2,
      postId: 5,
      userId: 3,
      comment: "所有人都应该保护野生动物!",
      comnentTime: "4m"),
];
