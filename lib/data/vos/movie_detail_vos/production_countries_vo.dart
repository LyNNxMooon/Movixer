import 'package:json_annotation/json_annotation.dart';
part 'production_countries_vo.g.dart';

@JsonSerializable()
class ProductionCountriesVO {
  @JsonKey(name: 'iso_3166_1')
  final String iso;
  final String name;

  ProductionCountriesVO({required this.iso, required this.name});

  factory ProductionCountriesVO.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountriesVOFromJson(json);
}
