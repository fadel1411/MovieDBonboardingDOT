// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adapter_movie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieAdapterAdapter extends TypeAdapter<MovieAdapter> {
  @override
  final int typeId = 1;

  @override
  MovieAdapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieAdapter()
      ..original_title = fields[0] as String
      ..overview = fields[1] as String
      ..poster_path = fields[2] as String
      ..release_date = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, MovieAdapter obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.original_title)
      ..writeByte(1)
      ..write(obj.overview)
      ..writeByte(2)
      ..write(obj.poster_path)
      ..writeByte(3)
      ..write(obj.release_date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
