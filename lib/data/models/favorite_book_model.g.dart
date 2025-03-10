// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_book_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteBookModelAdapter extends TypeAdapter<FavoriteBookModel> {
  @override
  final int typeId = 1;

  @override
  FavoriteBookModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteBookModel(
      id: fields[0] as String,
      title: fields[1] as String,
      authors: (fields[2] as List?)?.cast<String>(),
      description: fields[3] as String?,
      thumbnail: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteBookModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.authors)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.thumbnail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteBookModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
