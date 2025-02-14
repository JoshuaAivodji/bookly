import 'package:bookly/core/errors/request_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:bookly/domain/entities/book_entity.dart';
import 'package:bookly/domain/repositories/book_repository.dart';

class SearchBooksUc {
  final BookRepository repository;

  SearchBooksUc({required this.repository});

  Future<Either<Failure, List<BookEntity>>> call(String query) {
    return repository.searchBooks(query);
  }
}
