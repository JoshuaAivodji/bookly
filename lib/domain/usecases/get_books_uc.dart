import 'package:bookly/core/errors/request_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:bookly/domain/entities/book_entity.dart';
import 'package:bookly/domain/repositories/book_repository.dart';

class GetBooksUc {
  final BookRepository repository;

  GetBooksUc({required this.repository});

  Future<Either<Failure, List<BookEntity>>> call({int startIndex = 0, int maxResults = 20}) {
    return repository.getBooks(startIndex: startIndex, maxResults: maxResults);
  }
}
