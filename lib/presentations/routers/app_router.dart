import 'package:bookly/presentations/pages/home/book_list_page.dart';
import 'package:bookly/presentations/pages/home/show_book_page.dart';
import 'package:bookly/presentations/routers/router_observer.dart';
import 'package:go_router/go_router.dart';


class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    observers: [
      AppRouterObserver(),
    ],
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const BookListPage(),
      ),
      GoRoute(
        path: '/book/:id',
        builder: (context, state) {
          final bookId = state.pathParameters['id']!;
          return ShowBookPage(bookId: bookId);
        },
      ),
    ],
  );
}
