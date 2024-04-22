import 'package:animal_app/models/animal_model.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class FavoriteData extends ChangeNotifier {
  static late Isar isar;

  // 初始化isar数据库
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([AnimalSchema], directory: dir.path, name: "animal");
    print("animal初始化成功");
  }

  // 默认数据写入
  static Future<void> addDefaultData(List<Animal> data) async {
    await isar.writeTxn(() => isar.animals.putAll(data));
    print("默认数据写入");
  }

  // 数据库操作
  // 添加数据
  Future<void> addData(Animal animal) async {
    await isar.writeTxn(() => isar.animals.put(animal));
    fetchData();
  }

  // 读取数据
  Future<List<Animal>> fetchData() async {
    List<Animal> fetchedAnimal = await isar.animals.where().findAll();
    return fetchedAnimal;
  }

  // 喜好返回
  Future<List<Animal>> findLikeData() async {
    final query = isar.animals.where().filter().isLikeEqualTo(true);
    List<Animal> fetchedAnimal = await query.findAll();
    print(fetchedAnimal);
    return fetchedAnimal;
  }

  // 修改数据
  // 这里是用于修改当前动物的喜爱状态的
  Future<void> updateData(int id) async {
    final existingData = await isar.animals.get(id);
    if (existingData != null) {
      existingData.isLike = !existingData.isLike;
      await isar.writeTxn(() => isar.animals.put(existingData));
      await fetchData();
    }
  }

  // 删除数据
  Future<void> deleteData(int id) async {
    await isar.writeTxn(() => isar.animals.delete(id));
    await fetchData();
  }

  // 删除所有数据
  static Future<void> deleteAllData() async {
    await isar.writeTxn(() => isar.animals.where().deleteAll());
  }

  // 找到对应的大类
  Future<List<Animal>> findSortData(String sortName) async {
    final query = isar.animals.where().filter().sortContains(sortName);
    final fetchedAnimal = await query.findAll();
    return fetchedAnimal;
  }

  // 查询详细信息
  Future<List<Animal>?> findData(String name) async {
    final query = isar.animals.where().filter().nameContains(name);
    final fetchedAnimals = await query.findAll();
    print(fetchedAnimals);

    if (fetchedAnimals.isNotEmpty) {
      return fetchedAnimals;
    } else {
      print("return null");
      return null;
    }
  }
}
