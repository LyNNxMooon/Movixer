// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spoken_language_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpokenLanguageVO _$SpokenLanguageVOFromJson(Map<String, dynamic> json) =>
    SpokenLanguageVO(
      englishName: json['english_name'] as String,
      iso: json['iso_639_1'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$SpokenLanguageVOToJson(SpokenLanguageVO instance) =>
    <String, dynamic>{
      'english_name': instance.englishName,
      'iso_639_1': instance.iso,
      'name': instance.name,
    };
