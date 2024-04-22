import 'package:animal_app/models/setting_model/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Signature extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  Signature({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("个性签名"),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(helperText: '输入个性签名'),
            ),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
                onPressed: () {
                  final nameManager =
                      Provider.of<Manager>(context, listen: false);
                  nameManager.updateSignature(_textEditingController.text);
                  Navigator.pop(context);
                },
                child: Text("确认"))
          ],
        ),
      ),
    );
  }
}
