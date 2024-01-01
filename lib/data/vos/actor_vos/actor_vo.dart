import 'package:json_annotation/json_annotation.dart';
import 'package:movixer/data/vos/actor_vos/actor_known_for_vo.dart';
part 'actor_vo.g.dart';

@JsonSerializable()
class ActorVO {
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
  @JsonKey(name: 'known_for')
  final List<ActorKnownForVO> knownFor;

  ActorVO(
      {required this.adult,
      required this.gender,
      required this.id,
      required this.knownForDepartment,
      required this.name,
      required this.originalName,
      required this.popularity,
      required this.profilePath,
      required this.knownFor});

  factory ActorVO.fromJson(Map<String, dynamic> json) =>
      _$ActorVOFromJson(json);
}
