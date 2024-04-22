import 'package:animal_app/models/setting_model/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UidModel extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  UidModel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UID设置"),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(helperText: '输入新UID'),
            ),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
                onPressed: () {
                  final uidManager =
                      Provider.of<Manager>(context, listen: false);
                  uidManager.updateUid(_textEditingController.text);
                  Navigator.pop(context);
                },
                child: Text("确认"))
          ],
        ),
      ),
    );
  }
}
