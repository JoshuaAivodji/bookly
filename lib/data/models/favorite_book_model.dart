import 'package:hive/hive.dart';

part 'favorite_book_model.g.dart';

@HiveType(typeId: 1)
class FavoriteBookModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final List<String>? authors;
  @HiveField(3)
  final String? description;
  @HiveField(4)
  final String? thumbnail;

  FavoriteBookModel({
    required this.id,
    required this.title,
    this.authors,
    this.description,
    this.thumbnail,
  });
}



