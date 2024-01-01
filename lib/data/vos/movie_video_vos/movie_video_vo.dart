import 'package:json_annotation/json_annotation.dart';
part 'movie_video_vo.g.dart';

@JsonSerializable()
class MovieVideoVO {
  @JsonKey(name: "iso_639_1")
  final String isoLanguage;
  @JsonKey(name: "iso_3166_1")
  final String isoRegion;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  @JsonKey(name: "published_at")
  final String publishedAt;
  final String id;

  MovieVideoVO(
      {required this.isoLanguage,
      required this.isoRegion,
      required this.name,
      required this.key,
      required this.site,
      required this.size,
      required this.type,
      required this.official,
      required this.publishedAt,
      required this.id});

  factory MovieVideoVO.fromJson(Map<String, dynamic> json) =>
      _$MovieVideoVOFromJson(json);
}
