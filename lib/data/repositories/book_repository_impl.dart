import 'dart:io';
import 'package:bookly/core/errors/dio_failures.dart';
import 'package:bookly/core/errors/request_failures.dart';
import 'package:bookly/data/models/mappers/favorite_book_mapper.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:bookly/data/models/book_model.dart';
import 'package:bookly/domain/entities/book_entity.dart';
import 'package:bookly/domain/repositories/book_repository.dart';
import 'package:bookly/data/datasources/remote/book_api_service.dart';
import 'package:retrofit/retrofit.dart';

import '../datasources/local/book_local_data_source.dart';



class BookRepositoryImpl implements BookRepository {
  final BookApiService apiService;
  final BookLocalDataSource localDataSource;

  BookRepositoryImpl({required this.apiService, required this.localDataSource});

  @override
  Future<Either<Failure, List<BookEntity>>> getBooks({int startIndex = 0, int maxResults = 20}) async {
    try {
      final HttpResponse<Book> httpResponse = await apiService.getBooks(
          startIndex: startIndex, maxResults: maxResults);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final books = httpResponse.data.items.map((book) => book.toEntity()).toList();
        return Right(books);
      } else {
        return const Left(NetworkFailure(message: 'Erreur de réseau inconnue'));
      }
    } on DioException catch (e) {
      return DioErrorHandler.handle(error: e);
    } catch (e) {
      return Left(NetworkFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> searchBooks(String query) async {
    try {
      final HttpResponse<Book> httpResponse = await apiService.searchBooks(query);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final books = httpResponse.data.items.map((book) => book.toEntity()).toList();
        return Right(books);
      } else {
        return const Left(NetworkFailure(message: 'Erreur de réseau inconnue'));
      }
    } on DioException catch (e) {
      return DioErrorHandler.handle(error: e);
    } catch (e) {
      return Left(NetworkFailure(message: e.toString()));
    }
  }

  // Local func
  @override
  Future<Either<Failure, void>> addToFavorites(BookEntity book) async {
    try {
      await localDataSource.addToFavorites(book.toFavoriteModel());
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromFavorites(String bookId) async {
    try {
      await localDataSource.removeFromFavorites(bookId);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getFavorites() async {
    try {
      final favorites = localDataSource
          .getFavorites()
          .map((model) => model.toEntity())
          .toList();
      return Right(favorites);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite(String bookId) async {
    try {
      final isFav = localDataSource.isFavorite(bookId);
      return Right(isFav);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}