import 'package:bookly/application/books/read/read_bloc.dart';
import 'package:bookly/application/theme/bloc/theme_bloc.dart';
import 'package:bookly/application/theme/bloc/theme_state.dart';
import 'package:bookly/core/configs/injection_container.dart';
import 'package:bookly/domain/usecases/add_to_favorites_uc.dart';
import 'package:bookly/domain/usecases/get_books_uc.dart';
import 'package:bookly/domain/usecases/is_favorite_uc.dart';
import 'package:bookly/domain/usecases/remove_from_favorites_uc.dart';
import 'package:bookly/domain/usecases/search_books_uc.dart';
import 'package:bookly/presentations/res/app_theme.dart';
import 'package:bookly/presentations/routers/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class AppInitPage extends StatefulWidget {
  const AppInitPage({super.key});

  @override
  State<AppInitPage> createState() => _AppInitPageState();
}

class _AppInitPageState extends State<AppInitPage> {


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
        BlocProvider<BooksBloc>(create: (context) => BooksBloc(
            getBooksUc: locator<GetBooksUc>(),
            searchBooksUc: locator<SearchBooksUc>(),
            addToFavoritesUc: locator<AddToFavoritesUc>(),
            removeFromFavoritesUc: locator<RemoveFromFavoritesUc>(),
            isFavoriteUc: locator<IsFavoriteUc>(),
        )),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Bookly',
            theme: AppTheme.lightTheme(context),
            darkTheme: AppTheme.darkTheme(context),
            themeMode: state.themeMode,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              ...GlobalMaterialLocalizations.delegates,
            ],
            locale: const Locale("fr"),
            builder: (context, child) => ResponsiveBreakpoints.builder(
              child: child!,
              breakpoints: [
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(start: 451, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
              ],
            ),
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }

}
