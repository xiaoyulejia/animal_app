import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'account_screen.dart';

class RigisterScreen extends StatefulWidget {
  RigisterScreen({super.key});

  @override
  State<RigisterScreen> createState() => _RigisterScreenState();
}

class _RigisterScreenState extends State<RigisterScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController(); // 新增确认密码控制器

  // 注册用户函数
  Future<bool> registerUser(String username, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? existingUser = prefs.getString(username);
    if (existingUser != null) {
      // 用户已存在
      return false;
    }
    await prefs.setString(username, password);
    return true;
  }

  void attemptRegister() async {
    if (usernameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      // 用户名或密码不能为空
      showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text('用户名和密码不能为空')));
    } else if (passwordController.text != confirmPasswordController.text) {
      // 密码和确认密码不一致
      showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text('密码和确认密码不一致')));
    } else {
      // 显示加载指示器
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()),
      );
      bool success =
          await registerUser(usernameController.text, passwordController.text);
      // 关闭加载指示器
      Navigator.pop(context);

      if (success) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(title: Text('注册成功'), actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // 返回上一个界面
                  },
                  child: Text('确认'),
                ),
              ]);
            });
      } else {
        // 用户名已被占用
        showDialog(
            context: context,
            builder: (context) => AlertDialog(title: Text('用户名已存在')));
      }
    }
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
                    height: 80,
                    width: 80,
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
                  "欢迎来到注册界面",
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
                const SizedBox(
                  height: 10,
                ),
                MyTextFiled(
                  controller: passwordController,
                  hinText: "密码",
                  obsecureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextFiled(
                  controller: confirmPasswordController, // 使用新的控制器
                  hinText: "确认密码",
                  obsecureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 27),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                //注册按钮
                GestureDetector(
                  onTap: attemptRegister,
                  child: Container(
                    padding: EdgeInsets.all(25),
                    margin: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12)),
                    child: const Center(
                        child: Text(
                      "注册",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black38,
                        ),
                      ),
                      Text(
                        '其他方式',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
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
                    const SizedBox(
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
                    const SizedBox(
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
