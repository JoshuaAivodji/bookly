import 'package:bookly/core/errors/request_failures.dart';
import 'package:bookly/domain/repositories/book_repository.dart';
import 'package:dartz/dartz.dart';

class RemoveFromFavoritesUc {
  final BookRepository repository;

  RemoveFromFavoritesUc({required this.repository});

  Future<Either<Failure, void>> call(String bookId) {
    return repository.removeFromFavorites(bookId);
  }
}
