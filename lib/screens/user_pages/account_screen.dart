import 'dart:io';

import 'package:animal_app/models/setting_model/aboutus_model.dart';
import 'package:animal_app/models/setting_model/database.dart';
import 'package:animal_app/models/setting_model/set_modle.dart';
import 'package:animal_app/models/setting_model/setadditional.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    final nameManager = Provider.of<Manager>(context);
    final uidManager = Provider.of<Manager>(context);
    final imagePathManager = Provider.of<Manager>(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: null,
      ),
      body: Column(
        children: [
          //头像等
          Container(
            color: Colors.white,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Container(
                    height: 66,
                    width: 66,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blueAccent,
                      // ignore: unnecessary_null_comparison
                      image: DecorationImage(
                        // 使用Manager类的imagePath数据
                        // ignore: unnecessary_null_comparison
                        image: imagePathManager.imagePath != null
                            ? FileImage(File(imagePathManager.imagePath))
                                as ImageProvider<Object>
                            : AssetImage(
                                    'assets/images/login&rigister/头像test.jpg')
                                as ImageProvider<Object>,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            '${nameManager.name}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        IconButton(
                            //后面添加
                            onPressed: null,
                            icon: Icon(
                              Icons.border_color,
                              size: 13,
                              color: Colors.blue[300],
                            ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 7),
                      child: Row(
                        children: [
                          Text(
                            "用户id：${uidManager.uid}",
                            style: TextStyle(
                                color: Color.fromARGB(145, 17, 16, 16),
                                fontSize: 13),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            width: 77,
                          ),
                          IconButton(
                              onPressed: null,
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              ))
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: 13,
          ),

          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AccountMessage("8", "动态"),
                SizedBox(
                  width: 56,
                ),
                AccountMessage("0", "收藏"),
                SizedBox(
                  width: 56,
                ),
                AccountMessage("13", "获赞")
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          //一些设置
          SafeArea(
            child: Column(
              children: [
                GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsScreen())),
                    child: Account(Icon(Icons.settings), "设置")),
                SizedBox(
                  height: 3,
                ),
                GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SetModule())),
                    child: Account(Icon(Icons.how_to_reg), "个人资料")),
                SizedBox(
                  height: 3,
                ),
                GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen())),
                  child: Account(Icon(Icons.login), "登录"),
                ),
                SizedBox(
                  height: 3,
                ),
                GestureDetector(
                  onTap: null,
                  child: Account(Icon(Icons.logout), "登出"),
                ),
                SizedBox(
                  height: 3,
                ),
                GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AboutUs())),
                    child: Account(Icon(Icons.lightbulb), "关于")),
                // 下面是我写的, 不要动哦----开始
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 12),
                      Icon(Icons.warning),
                      SizedBox(width: 20),
                      Text("重置(重载数据库)"),
                      Spacer(),
                      IconButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setBool('isFirstLaunch', true);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('重置成功'),
                                  content: Text('参数已成功重置！'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        SystemNavigator.pop();
                                      },
                                      child: Text('确定'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.restart_alt_rounded)),
                      SizedBox(width: 12),
                    ],
                  ),
                ),
                // ----结束------上面是我写的, 不要动哦
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Mybuttom extends StatelessWidget {
  final Function()? onTap;
  const Mybuttom({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.all(25),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(12)),
        child: Center(
            child: Text(
          "登录",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}

class MyTextFiled extends StatelessWidget {
  final controller;
  final String hinText;
  final bool obsecureText;
  const MyTextFiled(
      {super.key,
      this.controller,
      required this.hinText,
      required this.obsecureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        obscureText: obsecureText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 188, 187, 187)),
            ),
            fillColor: Color.fromARGB(255, 242, 238, 238),
            filled: true,
            hintText: hinText,
            hintStyle: TextStyle(color: Color.fromARGB(255, 199, 198, 193))),
      ),
    );
  }
}

//设置，个人资料，点击登录，退出登录，关于我们
Container Account(Icon icon, String text) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10.0),
    padding: EdgeInsets.symmetric(horizontal: 10.0),
    height: 55,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 12),
        icon,
        SizedBox(width: 20),
        Text(text),
        Spacer(),
        Icon(Icons.arrow_forward_ios),
        SizedBox(width: 18),
      ],
    ),
  );
}

//动态，获赞，收藏
Column AccountMessage(String count, String text) {
  return Column(
    children: [
      TextButton(
        onPressed: null,
        child: Text(count,
            style: TextStyle(color: Color.fromARGB(166, 205, 179, 29))),
      ),
      Text(
        text,
        style: TextStyle(color: Color.fromARGB(221, 97, 96, 94), fontSize: 12),
      )
    ],
  );
}
