import 'package:animal_app/models/setting_model/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NameSetPage extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  NameSetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的昵称"),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(helperText: '输入新昵称'),
            ),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
                onPressed: () {
                  final nameManager =
                      Provider.of<Manager>(context, listen: false);
                  nameManager.updateName(_textEditingController.text);
                  Navigator.pop(context);
                },
                child: Text("确认"))
          ],
        ),
      ),
    );
  }
}
