import 'package:bookly/data/models/favorite_book_model.dart';
import 'package:bookly/domain/entities/book_entity.dart';



// Extension to convert a FavoriteBookModel into a BookEntity
extension FavoriteBookMapper on FavoriteBookModel {

  /// Converts the Hive model [FavoriteBookModel] into a domain entity [BookEntity].
  /// This method is used to map local data to the domain.

  BookEntity toEntity() {
    return BookEntity(
      id: id,
      title: title,
      authors: authors,
      description: description,
      thumbnail: thumbnail,
    );
  }

}

// Extension to convert a BookEntity into a FavoriteBookModel
extension BookEntityMapper on BookEntity {

  /// Converts the domain entity [BookEntity] into a Hive model [FavoriteBookModel].
  /// This method is used to save data locally using Hive.

  FavoriteBookModel toFavoriteModel() {
    return FavoriteBookModel(
      id: id,
      title: title,
      authors: authors,
      description: description ?? '',
      thumbnail: thumbnail ?? '',
    );
  }

}
