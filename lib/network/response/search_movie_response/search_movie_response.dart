import 'package:json_annotation/json_annotation.dart';
import 'package:movixer/data/vos/movie_vos/movie_vo.dart';
part 'search_movie_response.g.dart';

@JsonSerializable()
class SearchMovieResponse {
  final int page;
  final List<MovieVO> results;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_results')
  final int totalResults;

  SearchMovieResponse(
      {required this.page,
      required this.results,
      required this.totalPages,
      required this.totalResults});

  factory SearchMovieResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchMovieResponseFromJson(json);
}
