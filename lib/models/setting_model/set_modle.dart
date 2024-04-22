import 'dart:io';

import 'package:animal_app/models/setting_model/database.dart';
import 'package:animal_app/models/setting_model/nameset_page.dart';
import 'package:animal_app/models/setting_model/signature.dart';
import 'package:animal_app/models/setting_model/uid_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SetModule extends StatefulWidget {
  const SetModule({super.key});

  @override
  State<SetModule> createState() => _SetModuleState();
}

class _SetModuleState extends State<SetModule> {
  @override
  Widget build(BuildContext context) {
    final nameManager = Provider.of<Manager>(context);
    final signatureManager = Provider.of<Manager>(context);
    final uidManager = Provider.of<Manager>(context);
    final imagePathManager = Provider.of<Manager>(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("个人资料"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () async {
              await showModalBottomSheet(
                context: context,
                builder: (context) => Wrap(
                  children: [
                    ListTile(
                      leading: Icon(Icons.camera_alt),
                      title: Text('拍照'),
                      onTap: () async {
                        await Manager()
                            .getImageAndSaveLocally(ImageSource.camera);
                        Navigator.of(context).pop();
                        setState(() {}); // 更新UI
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('从相册选择'),
                      onTap: () async {
                        await Manager()
                            .getImageAndSaveLocally(ImageSource.gallery);
                        Navigator.of(context).pop();
                        setState(() {}); // 更新UI
                      },
                    ),
                  ],
                ),
              );
            },
            child: Container(
              height: 88,
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("头像"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Row(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(90),
                            image: DecorationImage(
                              // 使用Manager类的imagePath数据
                              // ignore: unnecessary_null_comparison
                              image: imagePathManager.imagePath != null
                                  ? FileImage(File(imagePathManager.imagePath))
                                      as ImageProvider<Object>
                                  : AssetImage(
                                          'assets/images/login&rigister/头像test.jpg')
                                      as ImageProvider<Object>,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // ignore: unnecessary_null_comparison
                          child: imagePathManager.imagePath == null
                              ? Icon(Icons.person)
                              : null,
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          // Add more widgets below if needed

          GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => NameSetPage())),
            child: Container(
              height: 55,
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "昵称",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Row(
                      children: [
                        Text(nameManager.name,
                            style: TextStyle(color: Colors.grey)),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          GestureDetector(
            child: Container(
              height: 55,
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // 修改行的主轴对齐方式
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20), // 适当增加内边距以避免太靠近屏幕边缘
                    child: Text("性别"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Row(
                      children: [
                        Text(
                          "保密",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(width: 4), // 为了视觉效果，在图标和文字之间增加一些间距
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          GestureDetector(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Signature())),
            child: Container(
              height: 55,
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // 修改行的主轴对齐方式
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20), // 适当增加内边距以避免太靠近屏幕边缘
                    child: Text("个性签名"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Row(
                      children: [
                        Text(
                          signatureManager.signature,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(width: 4), // 为了视觉效果，在图标和文字之间增加一些间距
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          GestureDetector(
            child: Container(
              height: 55,
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // 修改行的主轴对齐方式
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20), // 适当增加内边距以避免太靠近屏幕边缘
                    child: Text("出生年月"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Row(
                      children: [
                        Text(
                          " 2023 年 12 月 12 日",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(width: 4), // 为了视觉效果，在图标和文字之间增加一些间距
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 33,
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UidModel()),
            ),
            child: Container(
              height: 55,
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // 修改行的主轴对齐方式
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20), // 适当增加内边距以避免太靠近屏幕边缘
                    child: Text("UID"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Row(
                      children: [
                        Text(
                          uidManager.uid,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(width: 4), // 为了视觉效果，在图标和文字之间增加一些间距
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 55,
          ),
          GestureDetector(
            child: Container(
              height: 55,
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // 修改行的主轴对齐方式
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20), // 适当增加内边距以避免太靠近屏幕边缘
                    child: Text("退出登录"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Row(
                      children: [
                        Text(
                          " ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(width: 4), // 为了视觉效果，在图标和文字之间增加一些间距
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
