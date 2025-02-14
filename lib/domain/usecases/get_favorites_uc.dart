import 'package:bookly/core/errors/request_failures.dart';
import 'package:bookly/domain/entities/book_entity.dart';
import 'package:bookly/domain/repositories/book_repository.dart';
import 'package:dartz/dartz.dart';

class GetFavoritesUc {
  final BookRepository repository;

  GetFavoritesUc({required this.repository});

  Future<Either<Failure, List<BookEntity>>> call() {
    return repository.getFavorites();
  }
}
