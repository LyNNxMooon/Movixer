// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_top_rated_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieTopRatedResponse _$MovieTopRatedResponseFromJson(
        Map<String, dynamic> json) =>
    MovieTopRatedResponse(
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => MovieVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );

Map<String, dynamic> _$MovieTopRatedResponseToJson(
        MovieTopRatedResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };
