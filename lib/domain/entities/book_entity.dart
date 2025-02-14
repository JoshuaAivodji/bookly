class BookEntity {
  final String id;
  final String title;
  final List<String>? authors;
  final String? description;
  final String? thumbnail;

  BookEntity({
    required this.id,
    required this.title,
    this.authors,
    this.description,
    this.thumbnail,
  });
}

