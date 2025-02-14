import 'package:bookly/application/books/read/read_event.dart';
import 'package:bookly/application/books/read/read_state.dart';
import 'package:bookly/domain/entities/book_entity.dart';
import 'package:bookly/domain/usecases/add_to_favorites_uc.dart';
import 'package:bookly/domain/usecases/get_books_uc.dart';
import 'package:bookly/domain/usecases/is_favorite_uc.dart';
import 'package:bookly/domain/usecases/remove_from_favorites_uc.dart';
import 'package:bookly/domain/usecases/search_books_uc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class BooksBloc extends Bloc<ReadBooksEvent, ReadBooksState> {
  final GetBooksUc getBooksUc;
  final SearchBooksUc searchBooksUc;
  final AddToFavoritesUc addToFavoritesUc;
  final RemoveFromFavoritesUc removeFromFavoritesUc;
  final IsFavoriteUc isFavoriteUc;


  final int _pageSize = 20;
  int _currentPage = 0;
  bool _hasReachedMax = false;
  List<BookEntity> allBooks = [];

  BooksBloc({required this.getBooksUc, required this.searchBooksUc,
    required this.addToFavoritesUc, required this.removeFromFavoritesUc,
    required this.isFavoriteUc}) : super(BooksInitial()) {
    on<LoadBooksEvent>(_onLoadDataBooks);
    on<LoadMoreBooksEvent>(_onLoadMoreBooks);
    on<SearchBooksEvent>(_onSearchBooks);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  Future<void> _onLoadDataBooks(LoadBooksEvent event, Emitter<ReadBooksState> emit) async {
    emit(BooksLoading());
    _currentPage = 0;
    _hasReachedMax = false;
    allBooks.clear();

    final result = await getBooksUc(startIndex: _currentPage * _pageSize, maxResults: _pageSize);

    result.fold(
          (failure) => emit(BooksError(failure.message)),
          (books) {
        allBooks.addAll(books);
        _hasReachedMax = books.length < _pageSize;
        emit(BooksLoaded(books: allBooks, hasReachedMax: _hasReachedMax));
      },
    );
  }

  Future<void> _onLoadMoreBooks(LoadMoreBooksEvent event, Emitter<ReadBooksState> emit) async {
    if (_hasReachedMax) return;

    _currentPage++;
    final result = await getBooksUc(startIndex: _currentPage * _pageSize, maxResults: _pageSize);

    result.fold(
          (failure) => emit(BooksError(failure.message)),
          (books) {
        _hasReachedMax = books.length < _pageSize;
        allBooks.addAll(books);
        emit(BooksLoaded(books: allBooks, hasReachedMax: _hasReachedMax));
      },
    );
  }

  Future<void> _onSearchBooks(SearchBooksEvent event, Emitter<ReadBooksState> emit) async {
    emit(BooksLoading());
    _currentPage = 0;
    _hasReachedMax = false;
    allBooks.clear();

    final result = await searchBooksUc.call(event.query);

    result.fold(
          (failure) => emit(BooksError(failure.message)),
          (books) {
        allBooks.addAll(books);
        _hasReachedMax = books.length < _pageSize;
        emit(BooksLoaded(books: allBooks, hasReachedMax: _hasReachedMax));
      },
    );
  }

  Future<void> _onToggleFavorite(ToggleFavoriteEvent event, Emitter<ReadBooksState> emit) async {
    final isFavoriteResult = await isFavoriteUc(event.book.id);

    isFavoriteResult.fold(
          (failure) => emit(BooksError(failure.message)),
          (isFavorite) async {
        if (isFavorite) {
          await removeFromFavoritesUc(event.book.id);
        } else {
          await addToFavoritesUc(event.book);
        }
        emit(BooksLoaded(books: [], hasReachedMax: false));
      },
    );
  }

}
