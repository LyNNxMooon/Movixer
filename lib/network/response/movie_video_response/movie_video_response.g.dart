// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_video_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieVideoResponse _$MovieVideoResponseFromJson(Map<String, dynamic> json) =>
    MovieVideoResponse(
      id: json['id'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => MovieVideoVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieVideoResponseToJson(MovieVideoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'results': instance.results,
    };
