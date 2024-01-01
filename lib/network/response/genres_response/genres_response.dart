import 'package:json_annotation/json_annotation.dart';
import 'package:movixer/data/vos/genres_vos/genres_vos.dart';
part 'genres_response.g.dart';

@JsonSerializable()
class GenresResponse {
  final List<GenresVO> genres;

  GenresResponse({required this.genres});

  factory GenresResponse.fromJson(Map<String, dynamic> json) =>
      _$GenresResponseFromJson(json);
}
