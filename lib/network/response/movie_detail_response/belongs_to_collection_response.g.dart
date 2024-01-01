// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'belongs_to_collection_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BelongsToCollectionResponse _$BelongsToCollectionResponseFromJson(
        Map<String, dynamic> json) =>
    BelongsToCollectionResponse(
      id: json['id'] as int,
      name: json['name'] as String,
      backdropPath: json['backdrop_path'] as String,
      posterPath: json['poster_path'] as String,
    );

Map<String, dynamic> _$BelongsToCollectionResponseToJson(
        BelongsToCollectionResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'poster_path': instance.posterPath,
      'backdrop_path': instance.backdropPath,
    };
