import 'package:json_annotation/json_annotation.dart';
part 'cast_vo.g.dart';

@JsonSerializable()
class CastVO {
  final bool adult;
  final int gender;
  final int id;
  @JsonKey(name: 'known_for_department')
  final String knownForDepartment;
  final String name;
  @JsonKey(name: 'original_name')
  final String originalName;
  final double popularity;
  @JsonKey(name: 'profile_path')
  String? profilePath;
  @JsonKey(name: 'cast_id')
  final int castId;
  final String character;
  @JsonKey(name: 'credit_id')
  final String creditId;
  final int order;

  CastVO(
      {required this.adult,
      required this.gender,
      required this.id,
      required this.knownForDepartment,
      required this.name,
      required this.originalName,
      required this.popularity,
      required this.profilePath,
      required this.castId,
      required this.character,
      required this.creditId,
      required this.order});

  factory CastVO.fromJson(Map<String, dynamic> json) => _$CastVOFromJson(json);
}
