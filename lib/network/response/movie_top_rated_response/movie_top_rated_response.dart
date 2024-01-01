import 'package:json_annotation/json_annotation.dart';
import 'package:movixer/data/vos/movie_vos/movie_vo.dart';
part 'movie_top_rated_response.g.dart';

@JsonSerializable()
class MovieTopRatedResponse {
  final int page;
  final List<MovieVO> results;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_results')
  final int totalResults;

  MovieTopRatedResponse(
      {required this.page,
      required this.results,
      required this.totalPages,
      required this.totalResults});

  factory MovieTopRatedResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieTopRatedResponseFromJson(json);
}
