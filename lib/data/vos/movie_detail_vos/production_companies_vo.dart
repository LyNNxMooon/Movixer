import 'package:json_annotation/json_annotation.dart';
part 'production_companies_vo.g.dart';

@JsonSerializable()
class ProductionCompanyVO {
  final int id;
  @JsonKey(name: 'logo_path')
  final String? logoPath;
  final String name;
  @JsonKey(name: 'origin_country')
  final String originCountry;

  ProductionCompanyVO(
      {required this.id,
      required this.logoPath,
      required this.name,
      required this.originCountry});

  factory ProductionCompanyVO.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyVOFromJson(json);
}
