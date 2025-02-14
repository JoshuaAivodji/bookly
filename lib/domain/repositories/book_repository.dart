import 'package:bookly/core/errors/request_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:bookly/domain/entities/book_entity.dart';

abstract class BookRepository {
  Future<Either<Failure, List<BookEntity>>> getBooks({int startIndex, int maxResults});
  Future<Either<Failure, List<BookEntity>>> searchBooks(String query);

  // Favoris local
  Future<Either<Failure, void>> addToFavorites(BookEntity book);
  Future<Either<Failure, void>> removeFromFavorites(String bookId);
  Future<Either<Failure, List<BookEntity>>> getFavorites();
  Future<Either<Failure, bool>> isFavorite(String bookId);
}
