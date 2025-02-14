import 'package:bookly/core/errors/request_failures.dart';
import 'package:bookly/domain/repositories/book_repository.dart';
import 'package:dartz/dartz.dart';

class IsFavoriteUc {
  final BookRepository repository;

  IsFavoriteUc({required this.repository});

  Future<Either<Failure, bool>> call(String bookId) {
    return repository.isFavorite(bookId);
  }
}
