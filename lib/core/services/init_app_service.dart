import 'package:bookly/core/configs/injection_container.dart';
import 'package:bookly/data/models/favorite_book_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';


Future<void> initAppServices() async {
  await dotenv.load();
  await initHive();
  setupLocator();
}

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteBookModelAdapter());

  // Ouvrez et enregistrez chaque boîte dans le Service Locator
  final favoriteBooksBox = await Hive.openBox<FavoriteBookModel>('favorite_books');
  locator.registerSingleton<Box<FavoriteBookModel>>(favoriteBooksBox);

}