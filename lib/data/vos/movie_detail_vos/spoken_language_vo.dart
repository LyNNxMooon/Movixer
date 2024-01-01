import 'package:json_annotation/json_annotation.dart';
part 'spoken_language_vo.g.dart';

@JsonSerializable()
class SpokenLanguageVO {
  @JsonKey(name: 'english_name')
  final String englishName;
  @JsonKey(name: 'iso_639_1')
  final String iso;
  final String name;

  SpokenLanguageVO(
      {required this.englishName, required this.iso, required this.name});

  factory SpokenLanguageVO.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguageVOFromJson(json);
}
