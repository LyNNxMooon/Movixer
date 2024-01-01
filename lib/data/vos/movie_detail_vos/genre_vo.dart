import 'package:json_annotation/json_annotation.dart';
part 'genre_vo.g.dart';

@JsonSerializable()
class MovieDetailGenreVO {
  final int id;
  final String name;

  MovieDetailGenreVO({required this.id, required this.name});

  factory MovieDetailGenreVO.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailGenreVOFromJson(json);
}
