import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  late ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 10));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            backgroundColor: Colors.grey[200],
            title: Text("关于"),
          ),
          body: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    print("点击");
                    _controller.play();
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    child: Image(
                      image: AssetImage("assets/images/icon.png"),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("v 2.0.0 20240415  "),
                    Text("蔚生"),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  child: Text("欢迎您踏入这个旨在守护地球生灭细微之处的空间。"
                      "在这里，我们共同探索保护濒危物种的重要性，唤醒人心中对自然的敬畏与责任。"
                      "每一种生命都是自然精心织就的奇迹，它们的消失，不仅是生态多样性的流失，更是人类文明的贫瘠。"
                      "让我们携手，用行动和智慧，给予这些无声的生灵一个光明的未来。"),
                ),
                SizedBox(height: 30.0),
                Column(
                  children: [
                    Text(
                      "开发团队",
                      style: TextStyle(fontSize: 24.0),
                    ),
                    SizedBox(height: 10),
                    DevInfo(
                        url:
                            "https://i0.hdslb.com/bfs/new_dyn/3d8c6da0b5e40372897d1852876d3626106307213.png",
                        name: "小娱乐家",
                        sub: "xiaoyulejiac@gmail.com"),
                    SizedBox(height: 10),
                    DevInfo(
                        url:
                            "https://i0.hdslb.com/bfs/new_dyn/47dcd977c18696a27334a7ce34c19fde475578564.jpg",
                        name: "小九",
                        sub: "xiaojiucupid@gmail.com"),
                    SizedBox(height: 10),
                    DevInfo(
                        url:
                            "http://i0.hdslb.com/bfs/new_dyn/5f595d50112f972b9b0400193ba4b034416571322.jpg",
                        name: "耀",
                        sub: "1774263165@qq.com"),
                  ],
                )
              ],
            ),
          ),
        ),
        ConfettiWidget(
          confettiController: _controller,
          blastDirection: pi / 2,
        ),
      ],
    );
  }
}

class DevInfo extends StatelessWidget {
  final String url;
  final String name;
  final String sub;

  DevInfo({
    super.key,
    required this.url,
    required this.name,
    required this.sub,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(url),
          ),
          title: Text(name),
          subtitle: Text(sub),
        ),
      ),
    );
  }
}
