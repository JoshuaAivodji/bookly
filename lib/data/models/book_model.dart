import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/book_entity.dart';

part 'book_model.g.dart';


@JsonSerializable()
class Book {
  String kind;
  int totalItems;
  List<BookItems> items;

  Book({required this.kind, required this.totalItems, required this.items});

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);
}


@JsonSerializable()
class BookItems {
  String? kind;
  String? id;
  String? etag;
  String? selfLink;
  VolumeInfo? volumeInfo;

  BookItems({this.kind, this.id, this.etag, this.selfLink,
    this.volumeInfo});

  factory BookItems.fromJson(Map<String, dynamic> json) => _$BookItemsFromJson(json);
  Map<String, dynamic> toJson() => _$BookItemsToJson(this);
}


@JsonSerializable()
class VolumeInfo {
  String? title;
  String? publishedDate;
  String? description;
  ImageLinks? imageLinks;
  String? infoLink;
  List<String>? authors;


  VolumeInfo({this.title, this.publishedDate, this.description,
    this.imageLinks, this.infoLink, this.authors});

  factory VolumeInfo.fromJson(Map<String, dynamic> json) => _$VolumeInfoFromJson(json);
  Map<String, dynamic> toJson() => _$VolumeInfoToJson(this);
}

@JsonSerializable()
class ImageLinks {
 String? smallThumbnail;
 String? thumbnail;

  ImageLinks({this.smallThumbnail, this.thumbnail});

  factory ImageLinks.fromJson(Map<String, dynamic> json) => _$ImageLinksFromJson(json);
  Map<String, dynamic> toJson() => _$ImageLinksToJson(this);
}


extension BookMapper on BookItems {
  BookEntity toEntity() {
    return BookEntity(
      id: id ?? '',
      title: volumeInfo?.title ?? '',
      authors: volumeInfo?.authors ?? [],
      description: volumeInfo?.description ?? '',
      thumbnail: volumeInfo?.imageLinks?.thumbnail ?? ''
    );
  }
}


