import 'package:bookly/application/books/read/read_bloc.dart';
import 'package:bookly/application/books/read/read_event.dart';
import 'package:bookly/application/books/read/read_state.dart';
import 'package:bookly/core/configs/injection_container.dart';
import 'package:bookly/core/errors/request_failures.dart';
import 'package:bookly/domain/entities/book_entity.dart';
import 'package:bookly/domain/usecases/add_to_favorites_uc.dart';
import 'package:bookly/domain/usecases/is_favorite_uc.dart';
import 'package:bookly/domain/usecases/remove_from_favorites_uc.dart';
import 'package:bookly/presentations/res/typography/app_text_style.dart';
import 'package:dartz/dartz.dart' show Either;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}


class _BookListPageState extends State<BookListPage> {
  late PagingController<int, BookEntity> _pagingController;
  final TextEditingController _searchController = TextEditingController();




  @override
  void initState() {
    super.initState();
    _pagingController = PagingController<int, BookEntity>(firstPageKey: 0);
    _pagingController.addPageRequestListener((pageKey) {
      context.read<BooksBloc>().add(pageKey == 0 ? LoadBooksEvent() : LoadMoreBooksEvent());
    });
  }


  @override
  void dispose() {
    _searchController.dispose();
    _pagingController.dispose();
    super.dispose();
  }


  // Function to handle search input
  void _onSearchSubmitted(String query) {
    if (query.isNotEmpty) {
      _pagingController.itemList = null;
      context.read<BooksBloc>().add(SearchBooksEvent(query));
    }
  }

  // Function to clear the search and refresh the list
  void _onClearSearch() {
    _pagingController.itemList = null;
    _pagingController.refresh();
    context.read<BooksBloc>().add(LoadBooksEvent());
  }

  // Function to add or remove a book from favorites
  void _toggleFavorite(BookEntity book) {
    final isFavoriteUc = locator<IsFavoriteUc>();
    isFavoriteUc(book.id).then((result) {
      result.fold(
            (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur: ${failure.message}')),
          );
        },
            (isFavorite) async {
          if (isFavorite) {
            final removeFromFavoritesUc = locator<RemoveFromFavoritesUc>();
            await removeFromFavoritesUc(book.id);
          } else {
            final addToFavoritesUc = locator<AddToFavoritesUc>();
            await addToFavoritesUc(book);
          }
          setState(() {});
        },
      );
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Livres disponibles",
          style: AppTextStyle.textMedium14.copyWith(fontSize: 20, color: Colors.white),
        ),
      ),
      body: BlocBuilder<BooksBloc, ReadBooksState>(
          builder: (context, state) {
            if (state is BooksLoading && _pagingController.itemList == null) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BooksLoaded) {
              if (state.hasReachedMax) {
                _pagingController.appendLastPage(state.books);
              } else {
                _pagingController.appendPage(state.books, _pagingController.nextPageKey ?? 0);
              }
            } else if (state is BooksError) {
              _pagingController.error = state.message;
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    onSubmitted: _onSearchSubmitted,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: "Rechercher un livre...",
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _onClearSearch();
                        },
                      )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    ),
                  ),
                ),
                Expanded(
                  child: PagedGridView<int, BookEntity>(
                    pagingController: _pagingController,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    builderDelegate: PagedChildBuilderDelegate<BookEntity>(
                      itemBuilder: (context, book, index) {
                        return BlocBuilder<BooksBloc, ReadBooksState>(
                          builder: (context, state) {
                            final isFavoriteUc = locator<IsFavoriteUc>();
                            return FutureBuilder<Either<Failure, bool>>(
                              future: isFavoriteUc(book.id),
                              builder: (context, snapshot) {
                                final isFavorite = snapshot.data?.getOrElse(() => false) ?? false;
                                return Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                topRight: Radius.circular(8),
                                              ),
                                              child: book.thumbnail != null
                                                  ? Image.network(
                                                book.thumbnail!,
                                                fit: BoxFit.cover,
                                              )
                                                  : Container(
                                                color: Colors.grey[200],
                                                child: const Icon(Icons.book, size: 50),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              book.title,
                                              textAlign: TextAlign.start,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTextStyle.textSemiBold14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: InkWell(
                                          onTap: () => _toggleFavorite(book),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withValues(alpha: 0.2),
                                                  blurRadius: 4,
                                                  offset: const Offset(2, 2),
                                                ),
                                              ],
                                            ),
                                            padding: const EdgeInsets.all(4),
                                            child: Icon(
                                              isFavorite ? Icons.favorite : Icons.favorite_border,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      firstPageProgressIndicatorBuilder: (_) => const Center(child: CircularProgressIndicator()),
                      newPageProgressIndicatorBuilder: (_) => const Center(child: CircularProgressIndicator()),
                      noItemsFoundIndicatorBuilder: (context) => const Center(child: Text("Aucun livre trouvé")),
                      firstPageErrorIndicatorBuilder: (context) => const Center(child: Text("Erreur de chargement")),
                      newPageErrorIndicatorBuilder: (context) => const Center(child: Text("Erreur de chargement")),
                    ),
                  ),
                ),
              ],
            );
          },
        )
    );
  }
}