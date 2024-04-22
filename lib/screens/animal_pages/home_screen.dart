import 'package:animal_app/models/animal_model.dart';
import 'package:animal_app/models/favorite_database.dart';
import 'package:animal_app/screens/animal_pages/detail_screen.dart';
import 'package:animal_app/widgets/my_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String userInput;
  late Future<List<Animal>?> animal;
  final _textController = TextEditingController();

  late Future<List<Animal>> primatesFuture;

  Future<List<Animal>?> searchData(String text) async {
    return context.read<FavoriteData>().findData(text);
  }

  void showNoResultsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("没有找到结果"),
          content: Text("抱歉，没有找到与您的搜索匹配的结果。请尝试不同的搜索词。"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("确定"),
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 120.0),
              child: Text(
                '探寻世间所有的物种!',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      cursorColor: Theme.of(context).indicatorColor,
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: "你想搜索什么濒危物种?",
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Color(0xFFD8ECF1)),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _textController.clear();
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    userInput = _textController.text;
                    if (userInput.isEmpty) {
                      showNoResultsDialog(context);
                    } else {
                      searchData(userInput).then((result) {
                        if (result != null && result.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                animalsFu: Future.value(result), // 转换成正确的类型
                                isDetail: false,
                                userInput: userInput,
                              ),
                            ),
                          );
                        } else {
                          showNoResultsDialog(context);
                        }
                      });
                    }
                  },
                  icon: Icon(FontAwesomeIcons.magnifyingGlass),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            MyFutureBuilder(sortName: "兽类"),
            SizedBox(height: 20.0),
            MyFutureBuilder(sortName: "鸟类"),
            SizedBox(height: 20.0),
            MyFutureBuilder(sortName: "爬行类"),
            SizedBox(height: 20.0),
            MyFutureBuilder(sortName: "两栖类"),
            SizedBox(height: 20.0),
            MyFutureBuilder(sortName: "鱼类"),
            SizedBox(height: 20.0),
            MyFutureBuilder(sortName: "昆虫类"),
          ],
        ),
      ),
    );
  }
}
