import 'package:animal_app/models/animal_data.dart';
import 'package:animal_app/models/community_database.dart';
import 'package:animal_app/models/community_model/community_data.dart';
import 'package:animal_app/models/setting_model/database.dart';
import 'package:animal_app/models/favorite_database.dart';
import 'package:animal_app/models/setting_model/image_path.dart';
import 'package:animal_app/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 初始化 SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
  // TODO: 需要在正式环境将下面的改为false
  isFirstLaunch = true;

  // Isar数据库
  await FavoriteData.initialize();
  await CommunityDatabase.initialize();

  // 如果是第一次启动, 传入数据
  if (isFirstLaunch) {
    // TODO: 需要在正式环境将下面的改为false
    await prefs.setBool('isFirstLaunch', true);
    await FavoriteData.deleteAllData();
    await FavoriteData.addDefaultData(fishs);
    await CommunityDatabase.deleteAllData();
    await CommunityDatabase.addDefaultData(
        userData, postData, storyData, commentData);
  }
  // Hive数据库
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<String>('nameBox');
  await Hive.openBox<String>('signatureBox');
  await Hive.openBox<String>('uidBox');
  await Hive.openBox<String>('imagePathBox');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoriteData()),
        ChangeNotifierProvider(create: (context) => UserProfileProvider()),
        ChangeNotifierProvider(create: (context) => Manager()),
        ChangeNotifierProvider(create: (context) => CommunityDatabase()),
        // 在这里可以继续添加其他的providers
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '蔚生 DEV',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF3EBACE),
        indicatorColor: Color(0xFFD8ECF1),
        scaffoldBackgroundColor: Color(0xFFF3F5F7),
      ),
      home: MainPage(),
    );
  }
}
