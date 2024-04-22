import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('个性化'),
            onTap: () {
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('通知'),
            onTap: () {
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.security),
            title: Text('安全'),
            onTap: () {
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('聊天设置'),
            onTap: () {
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('语言'),
            onTap: () {
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('帮助 & 支持'),
            onTap: () {

            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('退出登录'),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SettingsScreen(),
  ));
}
