import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class Manager extends ChangeNotifier {
  Box<String> _nameBox = Hive.box<String>('nameBox');
  Box<String> _signatureBox = Hive.box<String>('signatureBox');
  Box<String> _uidBox = Hive.box<String>('uidBox');
  Box<String> _imagePathBox = Hive.box<String>('imagePathBox');

  String get name => _nameBox.get('name', defaultValue: 'Animal')!;
  String get signature =>
      _signatureBox.get('signature', defaultValue: '这个人很神秘，什么都没有留下')!;
  String get uid => _uidBox.get('uid', defaultValue: '42564667')!;
  String get imagePath =>
      _imagePathBox.get('imagePath') ?? 'assets/images/icon.png';

  void updateName(String newName) {
    _nameBox.put('name', newName);
    notifyListeners();
  }

  void updateSignature(String newSinature) {
    _signatureBox.put("signature", newSinature);
    notifyListeners();
  }

  void updateUid(String newUid) {
    _uidBox.put("uid", newUid);
    notifyListeners();
  }

  void updateImagePath(String newImagePath) {
    _imagePathBox.put("imagePath", newImagePath);
    notifyListeners();
  }

  Future<void> getImageAndSaveLocally(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      await saveImageLocally(imageFile);
      notifyListeners(); // 通知侦听器更新UI
    }
  }

  Future<void> saveImageLocally(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final fileName = image.path.split('/').last; // 获取文件名
    final file = File('$path/$fileName');
    await image.copy(file.path);
    // 更新 Manager 中的图片路径
    updateImagePath(file.path);
  }
}
