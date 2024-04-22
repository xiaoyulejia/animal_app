import 'package:isar/isar.dart';

part 'animal_model.g.dart';

@Collection()
class Animal {
  Id id = Isar.autoIncrement;
  // Id id;
  String imageUrl;
  String name; // 姓名
  String enName; // 学名
  String sort; // 大分类
  String sortDetail; // 具体分类
  String rank1; // 国家重点保护野生动物名录等级
  String rank2; // 中国生物多样性红色名录
  String rank3; // IUCN
  String rank4; // CITES
  String description; // 形态特征
  String comment;
  String location;
  bool isLike;

  Animal({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.enName,
    required this.sort,
    required this.sortDetail,
    required this.rank1,
    required this.rank2,
    required this.rank3,
    required this.rank4,
    required this.description,
    required this.comment,
    required this.location,
    required this.isLike,
  });
}
