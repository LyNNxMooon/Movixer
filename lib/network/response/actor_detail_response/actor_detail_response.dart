import 'package:json_annotation/json_annotation.dart';
part 'actor_detail_response.g.dart';

@JsonSerializable()
class ActorDetailResponse {
  final bool adult;
  @JsonKey(name: 'also_known_as')
  final List<String> alsoKnownAs;
  final String biography;
  final String birthday;
  String? deathday;
  final int gender;
  final String? homepage;
  final int id;
  @JsonKey(name: 'imdb_id')
  final String imdbId;
  @JsonKey(name: 'known_for_department')
  final String knownForDepartment;
  final String name;
  @JsonKey(name: 'place_of_birth')
  final String placeOfBirth;
  final double popularity;
  @JsonKey(name: 'profile_path')
  String? profilePath;

  ActorDetailResponse(
      {required this.adult,
      required this.alsoKnownAs,
      required this.biography,
      required this.birthday,
      required this.deathday,
      required this.gender,
      required this.homepage,
      required this.id,
      required this.imdbId,
      required this.knownForDepartment,
      required this.name,
      required this.placeOfBirth,
      required this.popularity,
      required this.profilePath});

  factory ActorDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$ActorDetailResponseFromJson(json);
}
