import 'package:bookly/core/configs/env_config.dart';
import 'package:bookly/data/datasources/local/book_local_data_source.dart';
import 'package:bookly/data/datasources/remote/book_api_service.dart' show BookApiService;
import 'package:bookly/data/models/favorite_book_model.dart' show FavoriteBookModel;
import 'package:bookly/data/repositories/book_repository_impl.dart';
import 'package:bookly/domain/repositories/book_repository.dart' show BookRepository;
import 'package:bookly/domain/usecases/add_to_favorites_uc.dart';
import 'package:bookly/domain/usecases/get_books_uc.dart';
import 'package:bookly/domain/usecases/get_favorites_uc.dart';
import 'package:bookly/domain/usecases/is_favorite_uc.dart';
import 'package:bookly/domain/usecases/remove_from_favorites_uc.dart';
import 'package:bookly/domain/usecases/search_books_uc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../networks/dio_client.dart';




final GetIt locator = GetIt.instance;

void setupLocator() {

  /// ==================================================================
  /// ********************** Services globaux ***************************
  /// ==================================================================
  locator.registerLazySingleton(() => EnvConfig());



  /// ==================================================================
  /// ********************** Data Sources (remote & local) ***********************
  /// ==================================================================

  //--Remote Data Source
  final BookApiService apiBook = DioClient.getBookApiService();
  locator.registerLazySingleton(() => apiBook);

  //--Local Data Source
  final favoriteBooksBox = locator<Box<FavoriteBookModel>>();
  locator.registerLazySingleton(() => BookLocalDataSource(favoriteBooksBox));


  /// ==================================================================
  /// ********************** Repositories ******************************
  /// ==================================================================
  locator.registerLazySingleton<BookRepository>(() => BookRepositoryImpl(
    apiService: locator<BookApiService>(),
    localDataSource: locator<BookLocalDataSource>(),
  ));


  /// ==================================================================
  /// ********************** Use Cases **********************************
  /// ==================================================================
  locator.registerLazySingleton(() => GetBooksUc(repository: locator<BookRepository>()));
  locator.registerLazySingleton(() => SearchBooksUc(repository: locator<BookRepository>()));
  locator.registerLazySingleton(() => AddToFavoritesUc(repository: locator<BookRepository>()));
  locator.registerLazySingleton(() => RemoveFromFavoritesUc(repository: locator<BookRepository>()));
  locator.registerLazySingleton(() => GetFavoritesUc(repository: locator<BookRepository>()));
  locator.registerLazySingleton(() => IsFavoriteUc(repository: locator<BookRepository>()));

}