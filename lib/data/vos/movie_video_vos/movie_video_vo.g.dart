// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_video_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieVideoVO _$MovieVideoVOFromJson(Map<String, dynamic> json) => MovieVideoVO(
      isoLanguage: json['iso_639_1'] as String,
      isoRegion: json['iso_3166_1'] as String,
      name: json['name'] as String,
      key: json['key'] as String,
      site: json['site'] as String,
      size: json['size'] as int,
      type: json['type'] as String,
      official: json['official'] as bool,
      publishedAt: json['published_at'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$MovieVideoVOToJson(MovieVideoVO instance) =>
    <String, dynamic>{
      'iso_639_1': instance.isoLanguage,
      'iso_3166_1': instance.isoRegion,
      'name': instance.name,
      'key': instance.key,
      'site': instance.site,
      'size': instance.size,
      'type': instance.type,
      'official': instance.official,
      'published_at': instance.publishedAt,
      'id': instance.id,
    };
