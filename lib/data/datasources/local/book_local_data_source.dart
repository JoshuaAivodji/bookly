import 'package:hive/hive.dart';
import 'package:bookly/data/models/favorite_book_model.dart';

class BookLocalDataSource {
  final Box<FavoriteBookModel> _favoritesBox;

  BookLocalDataSource(this._favoritesBox);

  Future<void> addToFavorites(FavoriteBookModel book) async {
    await _favoritesBox.put(book.id, book);
  }

  Future<void> removeFromFavorites(String bookId) async {
    await _favoritesBox.delete(bookId);
  }

  List<FavoriteBookModel> getFavorites() {
    return _favoritesBox.values.toList();
  }

  bool isFavorite(String bookId) {
    return _favoritesBox.containsKey(bookId);
  }
}
