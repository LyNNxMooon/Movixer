// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actors_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActorsResponse _$ActorsResponseFromJson(Map<String, dynamic> json) =>
    ActorsResponse(
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => ActorVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );

Map<String, dynamic> _$ActorsResponseToJson(ActorsResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };
