import 'package:bookly/core/errors/request_failures.dart';
import 'package:bookly/domain/entities/book_entity.dart';
import 'package:bookly/domain/repositories/book_repository.dart';
import 'package:dartz/dartz.dart';

class AddToFavoritesUc {
  final BookRepository repository;

  AddToFavoritesUc({required this.repository});

  Future<Either<Failure, void>> call(BookEntity book) {
    return repository.addToFavorites(book);
  }
}
