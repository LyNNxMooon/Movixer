import 'package:json_annotation/json_annotation.dart';
import 'package:movixer/data/vos/movie_vos/movie_vo.dart';
part 'movies_by_genres_response.g.dart';

@JsonSerializable()
class MoviesByGenresResponse {
  final int page;
  final List<MovieVO> results;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_results')
  final int totalResults;

  MoviesByGenresResponse(
      {required this.page,
      required this.results,
      required this.totalPages,
      required this.totalResults});

  factory MoviesByGenresResponse.fromJson(Map<String, dynamic> json) =>
      _$MoviesByGenresResponseFromJson(json);
}
