import 'package:flutter/material.dart';

class ReleasePage extends StatelessWidget {
  const ReleasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("发布动态"),
        actions: [FloatingActionButton(onPressed: () {})],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(color: Colors.grey),
              )
            ],
          ),
        ],
      ),
    );
  }
}
