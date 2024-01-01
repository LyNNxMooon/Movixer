// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'production_countries_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductionCountriesVO _$ProductionCountriesVOFromJson(
        Map<String, dynamic> json) =>
    ProductionCountriesVO(
      iso: json['iso_3166_1'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$ProductionCountriesVOToJson(
        ProductionCountriesVO instance) =>
    <String, dynamic>{
      'iso_3166_1': instance.iso,
      'name': instance.name,
    };
