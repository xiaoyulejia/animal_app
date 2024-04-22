import 'package:animal_app/models/setting_model/database.dart';
import 'package:animal_app/screens/user_pages/account_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'rigister_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // 用户登录函数
  Future<bool> loginUser(String username, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? savedPassword = prefs.getString(username);
    return savedPassword != null && savedPassword == password;
  }

  void SignedIn() async {
    // 显示对话框
    showDialog(
      context: context,
      barrierDismissible: false, // 防止用户点击背景关闭对话框
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // 模拟登录逻辑，比如网络请求验证等
    // bool isSuccess = await yourSignInFunction();
    await Future.delayed(Duration(seconds: 1)); // 假设登录逻辑耗时1秒
    bool isSuccess = true; // 假设登录成功

    // 如果登录成功
    if (isSuccess) {
      // 然后延迟两秒
      await Future.delayed(Duration(seconds: 2));

      // 关闭对话框
      Navigator.pop(context);

      // 此处执行登录成功后的逻辑，跳转到HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AccountScreen()),
      );
    }
  }

  void wrongUserMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(title: Text('没有找到该用户'));
      },
    );
  }

  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(title: Text('密码错误'));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7EBEE),
      appBar: AppBar(
        backgroundColor: Color(0xFFE7EBEE),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //logo
                Center(
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/login&rigister/login_logo.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
                SizedBox(
                  height: 33,
                ),
                Text(
                  "欢迎来到登录界面",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                      fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                //登录框
                MyTextFiled(
                  controller: usernameController,
                  hinText: '用户名',
                  obsecureText: false,
                ),
                SizedBox(
                  height: 10,
                ),
                MyTextFiled(
                  controller: passwordController,
                  hinText: "密码",
                  obsecureText: true,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 27),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RigisterScreen())),
                          child: Container(
                            child: Text(
                              "注册",
                              style: TextStyle(color: Colors.blue[300]),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "忘记密码？",
                          style: TextStyle(color: Colors.blue[300]),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                //登录按钮
                Mybuttom(
                  onTap: () async {
                    // 显示加载对话框
                    showDialog(
                      context: context,
                      barrierDismissible: false, // 用户无法通过点击外部关闭对话框
                      builder: (context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );
                    // 尝试登录
                    var username = usernameController.text;
                    var password = passwordController.text;
                    bool isLoginSuccess = await loginUser(username, password);
                    // 关闭加载对话框
                    Navigator.pop(context);
                    // 登录逻辑
                    if (isLoginSuccess) {
                      final nameMannager =
                          Provider.of<Manager>(context, listen: false);
                      nameMannager.updateName(usernameController.text);
                      // 如果登录成功，可以跳转到主页面、显示成功消息等。
                      SignedIn();
                    } else {
                      // 此处应该是检查用户名是否存在。
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      final bool userExists = prefs.containsKey(username);
                      if (!userExists) {
                        // 如果用户不存在
                        wrongUserMessage();
                      } else {
                        // 如果用户存在但是密码错误
                        wrongPasswordMessage();
                      }
                    }
                  },
                ),

                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black38,
                        ),
                      ),
                      Text(
                        '其他方式',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Image.asset(
                            'assets/images/login&rigister/google(1).png'),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Image.asset(
                            'assets/images/login&rigister/QQlogo(1).png'),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      child: Container(
                          height: 50,
                          width: 50,
                          // decoration: BoxDecoration(color: Colors.red),
                          child: Image.asset(
                            'assets/images/login&rigister/微信logo(1).png',
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
