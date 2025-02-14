import 'package:bookly/domain/entities/book_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ReadBooksState extends Equatable {
  @override
  List<Object> get props => [];
}

class BooksInitial extends ReadBooksState {}

class BooksLoading extends ReadBooksState {}

class BooksLoaded extends ReadBooksState {
  final List<BookEntity> books;
  final bool hasReachedMax;

  BooksLoaded({required this.books, required this.hasReachedMax});
}

class BooksError extends ReadBooksState {
  final String message;
  BooksError(this.message);
}

