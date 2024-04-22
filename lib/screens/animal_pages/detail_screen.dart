import 'package:animal_app/models/animal_model.dart';
import 'package:animal_app/screens/animal_pages/animal_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailPage extends StatelessWidget {
  final bool isDetail;
  final String? userInput;
  final List<Animal>? animals;
  final Future<List<Animal>>? animalsFu;

  const DetailPage({
    super.key,
    this.animals,
    this.animalsFu,
    required this.isDetail,
    this.userInput,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Animal>>(
      future: animalsFu,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title:
                  isDetail ? Text("加载中...") : Text("包含${userInput ?? ''}的搜索结果"),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text("出错了"),
            ),
            body: Center(
              child: Text("发生错误：${snapshot.error}"),
            ),
          );
        } else {
          final List<Animal> animals = snapshot.data ?? [];
          if (animals.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            });
            return Scaffold(); // 返回空的 Scaffold
          } else if (animals.length == 1) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // 如果只有一个动物，直接跳转到目的地页面
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => DestinationScreen(animal: animals[0]),
                ),
              );
            });
            return Scaffold(); // 返回空的 Scaffold
          } else {
            // 计算需要生成的行数
            int itemCount = (animals.length / 2).ceil();
            return Scaffold(
              appBar: AppBar(
                title: isDetail
                    ? Text("${animals[0].sort}的所有数据")
                    : Text("包含${userInput ?? ''}的搜索结果"),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
                ),
              ),
              body: ListView.builder(
                itemCount: itemCount,
                itemBuilder: (BuildContext context, int index) {
                  int startIndex = index * 2;
                  int endIndex = startIndex + 1;
                  // 避免索引越界
                  endIndex = endIndex >= animals.length
                      ? animals.length - 1
                      : endIndex;

                  return Row(
                    children: [
                      Expanded(
                        child: AnimalDetail(animal: animals[startIndex]),
                      ),
                      SizedBox(width: 10), // 添加一些水平间距
                      Expanded(
                        child: AnimalDetail(animal: animals[endIndex]),
                      ),
                    ],
                  );
                },
              ),
            );
          }
        }
      },
    );
  }
}

class AnimalDetail extends StatelessWidget {
  final Animal animal;

  const AnimalDetail({Key? key, required this.animal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => DestinationScreen(animal: animal))),
      child: Container(
        margin: EdgeInsets.all(10.0),
        width: 210.0,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Positioned(
              bottom: 15.0,
              child: Container(
                height: 120.0,
                width: 200.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        animal.enName,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Stack(
                children: <Widget>[
                  Hero(
                    tag: animal.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: CachedNetworkImage(
                        width: 180,
                        height: 180,
                        imageUrl: animal.imageUrl,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10.0,
                    bottom: 10.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          animal.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.squarePollVertical,
                              size: 10.0,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              animal.rank1,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
