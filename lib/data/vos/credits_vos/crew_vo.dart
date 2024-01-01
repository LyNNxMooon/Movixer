import 'package:json_annotation/json_annotation.dart';
part 'crew_vo.g.dart';

@JsonSerializable()
class CrewVO {
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
  @JsonKey(name: 'credit_id')
  final String creditId;
  final String department;
  final String job;

  CrewVO(
      {required this.adult,
      required this.gender,
      required this.id,
      required this.knownForDepartment,
      required this.name,
      required this.originalName,
      required this.popularity,
      required this.profilePath,
      required this.creditId,
      required this.department,
      required this.job});

  factory CrewVO.fromJson(Map<String, dynamic> json) => _$CrewVOFromJson(json);
}
