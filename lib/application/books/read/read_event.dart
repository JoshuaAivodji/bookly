import 'package:bookly/domain/entities/book_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ReadBooksEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadBooksEvent extends ReadBooksEvent {}

class LoadMoreBooksEvent extends ReadBooksEvent {}

class SearchBooksEvent extends ReadBooksEvent {
  final String query;

  SearchBooksEvent(this.query);
}

class ToggleFavoriteEvent extends ReadBooksEvent {
  final BookEntity book;

  ToggleFavoriteEvent(this.book);
}